set :linked_dirs, fetch(:linked_dirs, []).push(
  'config/jwt',
  'files',
  'var/log',
  'public/media',
  'public/thumbnail',
  'public/sitemap'
)

set :linked_files, fetch(:linked_files, []).push(
  '.psh.yaml'
)

namespace :composer do
  task :install do
    on roles(:app) do
      within release_path do
        execute :composer, :install
      end
    end
  end
end

namespace :shopware do
  namespace :psh do
    task :execute, :param do |t, args|
      on roles(:app) do
        within release_path do
          execute './psh.phar', args[:param]
        end
      end
    end

    namespace :storefront do
      task :build do
        invoke! 'shopware:psh:execute', 'storefront:install-dependencies'
        invoke! 'shopware:psh:execute', 'storefront:build'
      end
    end

    namespace :administration do
      task :build do
        invoke! 'shopware:psh:execute', 'administration:install-dependencies'
        invoke! 'shopware:psh:execute', 'administration:build'
      end
    end
  end

  namespace :console do
    task :execute, :param do |t, args|
      on roles(:app) do
        within "#{current_path}" do
          execute 'bin/console', args[:param]
        end
      end
    end

    task :theme_compile do
      invoke! 'shopware:console:execute', 'theme:compile'
    end

    task :cache_clear do
      invoke! 'shopware:console:execute', 'cache:clear'
    end

    task :cache_warmup do
      invoke! 'shopware:console:execute', 'cache:warmup'
      invoke! 'shopware:console:execute', 'http:cache:warm:up'
    end

    task :assets_install do
      invoke! 'shopware:console:execute', 'assets:install'
    end

    task :database_migrate do
      invoke! 'shopware:console:execute', 'database:migrate --all'
    end

    task :maintenance_enable do
      invoke! 'shopware:console:execute', 'sales-channel:maintenance:enable --all'
    end

    task :maintenance_disable do
      invoke! 'shopware:console:execute', 'sales-channel:maintenance:disable --all'
    end
  end
end


namespace :deploy do
  after :updated, :shopware do
    invoke 'composer:install'
    invoke 'shopware:console:maintenance_enable'
    invoke 'shopware:console:database_migrate'
    invoke 'shopware:psh:administration:build'
    invoke 'shopware:psh:storefront:build'
    invoke 'shopware:console:assets_install'
  end

  after :published, :shopware do
    invoke 'shopware:console:maintenance_disable'
    invoke 'shopware:console:cache_warmup'
  end
end
