###
  profile.coffee
  profile.htmlから呼び出す
###
remote = require "remote"
profile = remote.require "../core/profile_core.js"
ut = remote.require "../core/util.js"

$ ->
  # Userモデルを生成
  class User extends Backbone.Model
    defaults: {
      type: ""
      userName: ""
    }
    validate: (attrs) ->
      if _.isEmpty(attrs.yype)
        return "SNS名を入力してください"
      if _.isEmpty(attrs.name)
        return "ユーザー名を入力してください"
    initialize: ->
      @on("invalid", (model, e) ->
        ut.console.debug "User error",e
        $.UIkit.modal.alert(e)
        return
      )
      return

  # Usersコレクションを生成
  class Users extends Backbone.Collection
    model: User

  # Profileモデルを生成
  class Profile extends Backbone.Model
    defaults: {
      name: "名前..."
      desc: "説明..."
      users: []
    }
    validate: (attrs) ->
      if _.isEmpty(attrs.name)
        return "プロファイル名を入力してください"
      #if users.length is 0
      #  return "アカウントが一つもありません"
    initialize: ->
      @on("invalid", (model, e) ->
        ut.console.debug "Profile error",e
        $.UIkit.modal.alert(e)
        return
      )
      return

  # Profilesコレクションを生成
  class Profiles extends Backbone.Collection
    model: Profile
    url: "../../../../config/profile.json"
    parse: (res) ->
      if res.error?
        ut.console.debug "Load error", res.error.message
        $.UIkit.modal.alert(res.error.message)
      return res
    initialize: ->
      @listenTo(@, "onFetch", @onFetch)
      @on("change", @update)
      @on("add", @update)
      @on("remove", @update)
      #@on("error", (model, error, options) -> console.log error)
      return
    onFetch: ->
      return
    update: (model, options) ->
      ut.console.debug "Profiles", "changed"
      profile.write(@.toJSON())
      return

  # ProfileViewを生成
  class ProfileView extends Backbone.View
    tagName: "dl"
    className: "uk-width-1-1 uk-margin-small-bottom"
    initialize: ->
      @model.on("destroy", @remove, @)
      @model.on("change", @render, @)
      return
    events: {
      "click #profileEdit": "edit"
      "click #profileDelete": "destroy"
    }
    edit: ->
      editProfileView.show(@model)
      return
    destroy: ->
      $.UIkit.modal.confirm("本当に削除してよろしいですか？", =>
        @model.destroy()
      )
      return
    remove: ->
      @$el.remove()
      return
    template: _.template($("#profile-template").html())
    render: ->
      template = @template(@model.toJSON())
      @$el.html(template)
      return @

  # ProfilesViewを生成
  class ProfilesView extends Backbone.View
    tagName: "div"
    className: "uk-grid"
    initialize: ->
      @collection.on("add", @addNew, @)
      return
    addNew: (profile) ->
      profileView = new ProfileView({model: profile})
      @$el.append(profileView.render().el)
      $("#createForm > #name").val("")
      $("#createForm > #desc").val("")
      return
    render: ->
      @collection.each( (profile) =>
        profileView = new ProfileView({model: profile})
        @$el.append(profileView.render().el)
      )
      return @

  # CreateProfileButtonViewの生成
  class CreateProfileButtonView extends Backbone.View
    el: "#create"
    events: {
      "click": "show"
    }
    show: ->
      @model.show(new Profile, true)
      return

  # プロファイルマネージャーの要素
  class EditProfileView extends Backbone.View
    el: "#createForm"
    model: Profile
    events: {
      "click #submit": "submit"
      "click #cancel": "hide"
    }
    submit: (e) ->
      e.preventDefault()
      if @isNew then @create() else @edit()
      @hide()
      return
    create: ->
      # Todo: users
      if @model.set({name: $("#createForm #name").val(), desc: $("#createForm #desc").val(), users: []}, {validate: true})
        @collection.add(@model)
      return
    edit: ->
      # Todo: users
      @model.set({name: $("#createForm #name").val(), desc: $("#createForm #desc").val(), users: []}, {validate: true})
      return
    show: (model, isNew = false) ->
      @model = model
      @isNew = isNew
      @render()
      $.UIkit.modal("#createForm", {keyboard: false, bgclose: false}).show()
      return
    hide: ->
      $.UIkit.modal("#createForm", {keyboard: false, bgclose: false}).hide()
      return
    render: ->
      $("#createForm #name").val(@model.toJSON().name)
      $("#createForm #desc").val(@model.toJSON().desc)
      return

  # profilesにインポート
  profiles = new Profiles()
  profiles.fetch({
    success: (collection, res, options) ->
      collection.trigger("onFetch")
      return
    error: ->
      $.UIkit.modal.alert("Errored getting profile.json")
      return
  })

  # ProfilesViewのインスタンス
  profilesView = new ProfilesView({collection: profiles})
  # EditProfilesViewのインスタンス
  editProfileView = new EditProfileView({collection: profiles})
  # CreateProfileButtonViewのインスタンス
  createProfileButtonView = new CreateProfileButtonView({model: editProfileView})

  # ProfilesViewを追加
  $("#title").after(profilesView.render().el)
  return
