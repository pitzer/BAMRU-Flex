PRIMARY      = "flex.bamru.info"
#BACKUP       = "backup.bamru.info"
#PRIMARY      = "primary"
#BACKUP       = "backup"

APPDIR       = "BAMRU-Flex"

set :application, "BAMRU-Flex"

load 'deploy' if respond_to?(:namespace)
Dir['vendor/plugins/*/recipes/*.rb'].each { |p| load p }
Dir['lib/shared/recipes/*.rb'].each { |p| load p }


