#
# Be sure to run `pod lib lint MKLoRaWAN-AD.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKLoRaWAN-AD'
  s.version          = '0.0.1'
  s.summary          = 'A short description of MKLoRaWAN-AD.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lovexiaoxia/MKLoRaWAN-AD'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lovexiaoxia' => 'aadyx2007@163.com' }
  s.source           = { :git => 'https://github.com/lovexiaoxia/MKLoRaWAN-AD.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '14.0'
  
  s.resource_bundles = {
    'MKLoRaWAN-AD' => ['MKLoRaWAN-AD/Assets/*.png']
  }
  
  s.subspec 'CTMediator' do |ss|
    ss.source_files = 'MKLoRaWAN-AD/Classes/CTMediator/**'
    
    ss.dependency 'MKBaseModuleLibrary'
    
    ss.dependency 'CTMediator'
  end
  
  s.subspec 'DatabaseManager' do |ss|
    
    ss.subspec 'SyncDatabase' do |sss|
      sss.source_files = 'MKLoRaWAN-AD/Classes/DatabaseManager/SyncDatabase/**'
    end
    
    ss.subspec 'LogDatabase' do |sss|
      sss.source_files = 'MKLoRaWAN-AD/Classes/DatabaseManager/LogDatabase/**'
    end
    
    ss.dependency 'MKBaseModuleLibrary'
    
    ss.dependency 'FMDB'
  end
  
  s.subspec 'SDK' do |ss|
    ss.source_files = 'MKLoRaWAN-AD/Classes/SDK/**'
    
    ss.dependency 'MKBaseBleModule'
  end
  
  s.subspec 'Target' do |ss|
    ss.source_files = 'MKLoRaWAN-AD/Classes/Target/**'
    
    ss.dependency 'MKLoRaWAN-AD/Functions'
  end
  
  s.subspec 'ConnectModule' do |ss|
    ss.source_files = 'MKLoRaWAN-AD/Classes/ConnectModule/**'
    
    ss.dependency 'MKLoRaWAN-AD/SDK'
    
    ss.dependency 'MKBaseModuleLibrary'
  end
  
  s.subspec 'Expand' do |ss|
    
    ss.subspec 'TextButtonCell' do |sss|
      sss.source_files = 'MKLoRaWAN-AD/Classes/Expand/TextButtonCell/**'
    end
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
  end
  
  s.subspec 'Functions' do |ss|
    
    ss.subspec 'AboutPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/AboutPage/Controller/**'
      end
    end
    
    ss.subspec 'AlarmReportSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/AlarmReportSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/AlarmTypeSettingsPage/Controller'
      end
    end
    
    ss.subspec 'AlarmTypeSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/AlarmTypeSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/AlarmTypeSettingsPage/Model'
        ssss.dependency 'MKLoRaWAN-AD/Functions/AlarmTypeSettingsPage/View'
      end
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/AlarmTypeSettingsPage/Model/**'
      end
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/AlarmTypeSettingsPage/View/**'
      end
    end
    
    ss.subspec 'BatteryConsumptionPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/BatteryConsumptionPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/BatteryConsumptionPage/Model'
        ssss.dependency 'MKLoRaWAN-AD/Functions/BatteryConsumptionPage/View'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/BatteryConsumptionPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/BatteryConsumptionPage/View/**'
      end
    end
    
    ss.subspec 'BleSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/BleSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/BleSettingsPage/Model'
        ssss.dependency 'MKLoRaWAN-AD/Functions/BleSettingsPage/View'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/BleSettingsPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/BleSettingsPage/View/**'
      end
      
    end
    
    ss.subspec 'DebuggerPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/DebuggerPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/DebuggerPage/View'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/DebuggerPage/View/**'
      end
      
    end
    
    ss.subspec 'DeviceInfoPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/DeviceInfoPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/DeviceInfoPage/Model'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/UpdatePage/Controller'
        ssss.dependency 'MKLoRaWAN-AD/Functions/SelftestPage/Controller'
        ssss.dependency 'MKLoRaWAN-AD/Functions/DebuggerPage/Controller'
        ssss.dependency 'MKLoRaWAN-AD/Functions/BatteryConsumptionPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/DeviceInfoPage/Model/**'
      end
      
    end
    
    ss.subspec 'DeviceSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/DeviceSettingPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/DeviceSettingPage/Model'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/IndicatorSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-AD/Functions/DeviceInfoPage/Controller'
        ssss.dependency 'MKLoRaWAN-AD/Functions/OnOffSettingsPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/DeviceSettingPage/Model/**'
      end
      
    end
    
    ss.subspec 'GeneralPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/GeneralPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/GeneralPage/Model'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/AlarmReportSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-AD/Functions/BleSettingsPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/GeneralPage/Model/**'
      end
      
    end
    
    ss.subspec 'IndicatorSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/IndicatorSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/IndicatorSettingsPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/IndicatorSettingsPage/Model/**'
      end
      
    end
    
    ss.subspec 'LoRaApplicationPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/LoRaApplicationPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/LoRaApplicationPage/Model'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/MessageTypePage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/LoRaApplicationPage/Model/**'
      end
      
    end
    
    ss.subspec 'LoRaPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/LoRaPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/LoRaPage/Model'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/LoRaSettingPage/Controller'
        ssss.dependency 'MKLoRaWAN-AD/Functions/LoRaApplicationPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/LoRaPage/Model/**'
      end
      
    end
    
    ss.subspec 'LoRaSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/LoRaSettingPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/LoRaSettingPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/LoRaSettingPage/Model/**'
      end
      
    end
    
    ss.subspec 'MessageTypePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/MessageTypePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/MessageTypePage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/MessageTypePage/Model/**'
      end
    end
    
    ss.subspec 'OnOffSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/OnOffSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/OnOffSettingsPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/OnOffSettingsPage/Model/**'
      end
      
    end
    
    ss.subspec 'ScanPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/ScanPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/ScanPage/Model'
        ssss.dependency 'MKLoRaWAN-AD/Functions/ScanPage/View'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/TabBarPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/ScanPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/ScanPage/View/**'
        ssss.dependency 'MKLoRaWAN-AD/Functions/ScanPage/Model'
      end
    end
    
    ss.subspec 'SelftestPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/SelftestPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/SelftestPage/View'
        ssss.dependency 'MKLoRaWAN-AD/Functions/SelftestPage/Model'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/SelftestPage/View/**'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/SelftestPage/Model/**'
      end
    end
    
    ss.subspec 'TabBarPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/TabBarPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/LoRaPage/Controller'
        ssss.dependency 'MKLoRaWAN-AD/Functions/GeneralPage/Controller'
        ssss.dependency 'MKLoRaWAN-AD/Functions/DeviceSettingPage/Controller'
      end
    end
    
    ss.subspec 'UpdatePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/UpdatePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-AD/Functions/UpdatePage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-AD/Classes/Functions/UpdatePage/Model/**'
      end
    end
    
    ss.dependency 'MKLoRaWAN-AD/SDK'
    ss.dependency 'MKLoRaWAN-AD/DatabaseManager'
    ss.dependency 'MKLoRaWAN-AD/CTMediator'
    ss.dependency 'MKLoRaWAN-AD/ConnectModule'
    ss.dependency 'MKLoRaWAN-AD/Expand'
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
    ss.dependency 'HHTransition'
    ss.dependency 'MLInputDodger'
    ss.dependency 'iOSDFULibrary',   '4.13.0'
    
  end
  
end
