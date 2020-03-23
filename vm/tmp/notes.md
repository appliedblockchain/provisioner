#### lightsail ruby client reference / documentation

original doc: (aws-cli)
https://docs.aws.amazon.com/cli/latest/reference/lightsail/index.html#cli-aws-lightsail

ruby reference:
https://github.com/aws/aws-sdk-ruby/blob/master/gems/aws-sdk-lightsail/lib/aws-sdk-lightsail/client.rb#L32 (you have to read or run rdoc on this file)


----

### lightsail.rb commands - single vms

deploys a single vm

    deploy_vm "test"

deletes a vm

    delete_vm name: "test"


----

```
# current config - do everything, this config (provision.rb:L4), skips everything:
#
# SETUP_ROOT_SSH = false
# INITIAL_APT_UPDATE = false
# INSTALL_PACKAGES = false
# INSTALL_DOCKER = false
```
