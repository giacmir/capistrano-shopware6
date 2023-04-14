Gem::Specification.new do |s|
  s.authors = ['Giacomo Mirabassi', 'Davide Borgia', 'Francesco Pisello']
  s.name = %q{capistrano_shopware6}
  s.version = "0.2.5"
  s.date = %q{2022-06-10}
  s.summary = %q{Capistrano deploy instructions for Shopware 6}
  s.require_paths = ["lib"]
  s.files = `git ls-files`.split($/)
  s.license = "OSL-3.0"
  s.homepage = 'https://github.com/giacmir/capistrano-shopware6'

  s.add_dependency 'capistrano', '~> 3.0'
end
