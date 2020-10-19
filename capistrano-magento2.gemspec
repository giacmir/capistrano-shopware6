Gem::Specification.new do |s|
  s.authors = ['Giacomo Mirabassi']
  s.name = %q{capistrano_shopware6}
  s.version = "0.1.0"
  s.date = %q{2020-08-28}
  s.summary = %q{Capistrano deploy instructions for Shopware 6}
  s.require_paths = ["lib"]
  s.files = `git ls-files`.split($/)
  s.license = "OSL-3.0"
  s.homepage = 'https://github.com/giacmir/capistrano-shopware6'

  s.add_dependency 'capistrano', '~> 3.0'
end
