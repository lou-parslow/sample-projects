require 'rake/clean'

CLEAN.include('NuGet.Net.Standard.Test/coverage.opencover.xml')
task :setup do
    puts `dotnet tool install --global dotnet-sonarscanner`
    puts `dotnet tool update --global dotnet-sonarscanner`
    FileUtils.mkdir('NuGet.Net.Standard') if(!Dir.exists?('NuGet.Net.Standard'))
    Dir.chdir('NuGet.Net.Standard') do
        puts `dotnet new classlib -lang C#` if(!File.exists?('NuGet.Net.Standard.csproj'))
    end
    FileUtils.mkdir('NuGet.Net.Standard.Test') if(!Dir.exists?('NuGet.Net.Standard.Test'))
    Dir.chdir('NuGet.Net.Standard.Test') do
        if(!File.exists?('NuGet.Net.Standard.Test.csproj'))
            puts `dotnet new nunit -lang C#`
            puts `dotnet add reference ../NuGet.Net.Standard/NuGet.Net.Standard.csproj`
            
        end
        puts `dotnet add package coverlet.msbuild`
    end
end

task :build do
    Dir.chdir('NuGet.Net.Standard.Test') do
        puts `dotnet build --configuration Release`
        puts `dotnet build --configuration Debug`
    end
end

task :test do
    Dir.chdir('NuGet.Net.Standard.Test') do
        puts `dotnet sonarscanner begin /k:"nuget-net-standard" /d:sonar.organization="sample-projects" /d:sonar.host.url="https://sonarcloud.io" /d:sonar.login="feeffb1fd694a13d783f150fcdb7fb0d6a0aabf7" /d:sonar.cs.opencover.reportsPaths="coverage.opencover.xml"`
        puts `dotnet test --configuration Release  NuGet.Net.Standard.Test.csproj /p:CollectCoverage=true /p:CoverletOutputFormat=opencover`
        puts `dotnet sonarscanner end  /d:sonar.login="feeffb1fd694a13d783f150fcdb7fb0d6a0aabf7"`
    end
    
end

task :default => [:setup,:build,:test]