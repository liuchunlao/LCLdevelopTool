Pod::Spec.new do |s|
s.name        = 'LCLdevelopTool'
s.version     = '1.0.3'
s.authors     = { 'liucl' => 'liuchunlao@qq.com' }
s.homepage    = 'https://github.com/liuchunlao/LCLdevelopTool'
s.summary     = 'an easy tool for developing.'
s.source      = { :git => 'https://github.com/liuchunlao/LCLdevelopTool.git',
:tag => "1.0.3" }
s.license     = { :type => "MIT", :file => "LICENSE" }

s.platform = :ios, '8.0'
s.requires_arc = true
s.source_files = 'LCLdevelopTool/LDTool/*.{h,m}'

end
