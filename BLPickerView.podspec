Pod::Spec.new do |s|
s.name = 'BLPickerView'
s.version = '1.0.0'
s.license = { :type => "MIT"}
s.summary = 'A PickerView on iOS.'
s.homepage = 'https://github.com/boundlessocean/pickView'
s.authors = { 'ocean' => 'boundlessocean@icloud.com' }
s.source = { :git => 'https://github.com/boundlessocean/pickView.git',  :tag => s.version.to_s }
s.ios.deployment_target = '8.0'
s.source_files = 'PickViewDemo/BLPickView/*.{h,m}'
end