# CBBasicUtils
        曹博的pod库
        因为 中间使用了一些xib文件，所以在创建pod库的时候，需要添加下面的句柄：

        post_install do |installer|
            installer.pods_project.targets.each do |target|
                target.build_configurations.each do |config|
                    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
            end
        end
