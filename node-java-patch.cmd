@echo off
:: node-java-patch

git apply node-java-maven-option.patch
node_modules\\.bin\\node-java-maven

exit /b