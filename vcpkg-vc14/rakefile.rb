require 'dev'

task :setup do
	puts `vcpkg install boost-test`
	puts `vcpkg integrate install`
end