# CBSpeechTest
      iOS 实时录音转文字——Speech框架的使用
      一时心血来潮，搞了个语音转文字的demo项目，开源出来，给大家做点贡献！
      
      具体过程如下：
      https://www.jianshu.com/p/0e7d5dea3aad

代码过程：
### 添加Speech Framework

TARGET --》General -》Linked Frameworks and Libraries
添加 Speech
并在项目中添加speech头文件

### 申请权限

添加NSSpeechRecognitionUsageDescription 和 NSMicrophoneUsageDescription 权限申请

### 在info-plist 中添加
```
    <key>NSSpeechRecognitionUsageDescription</key>
    <string>测试请求使用语音识别</string>
    <key>NSMicrophoneUsageDescription</key>
    <string>测试请求使用麦克风权限</string>
```
### 添加录音和转换控件

创建一个语音控制器。创建一个语音识别请求。创建一个管理语音任务管理器。还有一个录音设备。并且给管理器添加代理方法。
```
@interface ViewController ()<SFSpeechRecognizerDelegate>
      
@property (nonatomic,strong)SFSpeechRecognizer *recognizer;
@property(nonatomic,strong)SFSpeechAudioBufferRecognitionRequest * recognitionRequest;
@property(nonatomic,strong)SFSpeechRecognitionTask * recognitionTask ;
@property (nonatomic,strong)AVAudioEngine * audioEngine;
```

### 将设备识别语音为中文

 NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"];
    _recognizer = [[SFSpeechRecognizer alloc] initWithLocale:locale];
    
    //把语音识别的代理设置为 self
    _recognizer.delegate = self;

### 发送语音认证请求(首先要判断设备是否支持语音识别功能)
```
    //发送语音认证请求(首先要判断设备是否支持语音识别功能)
    [self requestJurisdiction];

-(void)requestJurisdiction{
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        
        BOOL isButtonEnable = NO;
        
        //检查验证的状态。如果被授权了，让microphone按钮有效。如果没有，打印错误信息然后让microphone按钮失效。
        switch (status) {
                case SFSpeechRecognizerAuthorizationStatusAuthorized:
            {
                isButtonEnable = YES;
                NSLog(@"用户授权语音识别");
            }
                break;
                
                case SFSpeechRecognizerAuthorizationStatusDenied:
            {
                isButtonEnable = NO;
                NSLog(@"用户拒绝授权语音识别");
            }
                break;
                case SFSpeechRecognizerAuthorizationStatusRestricted:
            {
                isButtonEnable = NO;
                NSLog(@"设备不支持语音识别功能");
            }
                break;
                case SFSpeechRecognizerAuthorizationStatusNotDetermined:
            {
                isButtonEnable = NO;
                NSLog(@"结果未知 用户尚未进行选择");
            }
                break;
        }
    }];
}
```
### 创建录音引擎。
```
self.audioEngine = [[AVAudioEngine alloc]init];
```
### 按钮点击事件
```
- (IBAction)startBtnPress:(id)sender {
    if ([self.audioEngine isRunning]) {
        [self.audioEngine stop];
        [self.recognitionRequest endAudio];
    }else{
        [self startRecording];
        self.stateLb.text = @"录音进行中。。。";
    }
}
```
### 开始录音

```
-(void)startRecording{
    if (self.recognitionTask) {
        [self.recognitionTask cancel];
        self.recognitionTask = nil;
    }
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    bool  audioBool = [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    bool  audioBool1= [audioSession setMode:AVAudioSessionModeMeasurement error:nil];
    bool  audioBool2= [audioSession setActive:true withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    if (audioBool || audioBool1||  audioBool2) {
        NSLog(@"可以使用");
    }else{
        NSLog(@"这里说明有的功能不支持");
    }
    self.recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc]init];
    AVAudioInputNode *inputNode = self.audioEngine.inputNode;
    
    self.recognitionRequest.shouldReportPartialResults = true;
    
    //开始识别任务
    self.recognitionTask = [self.recognizer recognitionTaskWithRequest:self.recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        bool isFinal = false;
        if (result) {
            self.voiceContentLb.text = [[result bestTranscription] formattedString];
            //语音转文本
            isFinal = [result isFinal];
        }
        if (error || isFinal) {
            [self.audioEngine stop];
            [inputNode removeTapOnBus:0];
            self.recognitionRequest = nil;
            self.recognitionTask = nil;
        }
    }];
    AVAudioFormat *recordingFormat = [inputNode outputFormatForBus:0];
    [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        [self.recognitionRequest appendAudioPCMBuffer:buffer];
    }];
    [self.audioEngine prepare];
    bool audioEngineBool = [self.audioEngine startAndReturnError:nil];
    NSLog(@"%d",audioEngineBool);
    self.voiceContentLb.text = @"姑娘,聊十块钱的";
}
```
### 结束录音
```
- (IBAction)endBtnPress:(id)sender {
    if ([self.audioEngine isRunning]) {
        [self.audioEngine stop];
        [self.recognitionRequest endAudio];
    }
    self.stateLb.text = @"录音结束";
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:2.0];
}

-(void)delayMethod{
    self.stateLb.text = @"";
}
```
### 设置代理方法。
```
//当语音识别操作可用性发生改变时会被调用
- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available{
    if (available) {
        
    }else{
        
    }
}
```
