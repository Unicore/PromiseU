Pod::Spec.new do |s|
  s.name = 'PromiseU'
  s.version = '0.1.0'
  s.swift_version = '4.2'
  s.license = 'MIT'
  s.summary = 'Promise class and syntax sugar'
  s.homepage = 'https://github.com/Unicore/PromiseU.git'
  s.authors = { 'Maxim Bazarov' => 'bazaroffma@gmail.com.org' }
  s.source = { :git => 'https://github.com/Unicore/PromiseU.git', :tag => s.version }

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'Source/**/*.swift'
end
