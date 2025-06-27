cat > settings.xml <<- EOM
<+secrets.getValue("account.settingsXML")>
EOM
mvn -Dmaven.compile.skip -Dmaven.test.skip deploy -s settings.xml