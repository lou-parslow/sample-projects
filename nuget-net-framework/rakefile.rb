require 'rake/clean'
VERSION='0.0.0'
rake_dir=File.dirname(__FILE__)
task :setup do

end

task :build do
	puts `msbuild NuGet.Net.Framework.sln /p:Configuration=Debug`
	puts `msbuild NuGet.Net.Framework.sln /p:Configuration=Release`
end

task :test => [:build] do
	runner="#{rake_dir}/packages/NUnit.ConsoleRunner.3.9.0/tools/nunit3-console.exe"
	puts `#{runner} NuGet.Net.Framework.Test/bin/Release/NuGet.Net.Framework.Test.dll`
	opencover="#{rake_dir}/packages/OpenCover.4.6.519/tools/OpenCover.Console.exe"
	Dir.chdir('NuGet.Net.Framework.Test/bin/Release') do
		puts `SonarScanner.MSBuild.exe begin /k:"nuget-net-framework" /d:sonar.organization="sample-projects" /d:sonar.host.url="https://sonarcloud.io" /d:sonar.login="b2d87b78f07b47819ae71851d1c8aaf6ca0ec201" /d:sonar.cs.opencover.reportsPaths="coverage.opencover.xml" /v:"#{VERSION}"`
		puts `msbuild ../../../NuGet.Net.Framework.sln /p:Configuration=Release`
		puts `#{opencover} -target:#{runner} -targetargs:"NuGet.Net.Framework.Test.dll" -register:user -output:coverage.opencover.xml -filter:"+[NuGet*]* -[Test]*`
		puts `SonarScanner.MSBuild.exe end /d:sonar.login="b2d87b78f07b47819ae71851d1c8aaf6ca0ec201"`
	end
end


task :default => [:setup,:build,:test]