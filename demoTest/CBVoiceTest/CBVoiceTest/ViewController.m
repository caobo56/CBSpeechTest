//
//  ViewController.m
//  CBVoiceTest
//
//  Created by caobo56 on 2018/1/18.
//  Copyright © 2018年 caobo56. All rights reserved.
//

#import "ViewController.h"
#import <Speech/Speech.h>
#import <UIView+toast.h>

@interface ViewController ()<SFSpeechRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *voiceContentLb;

@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@property (weak, nonatomic) IBOutlet UIButton *endBtn;

@property (weak, nonatomic) IBOutlet UILabel *stateLb;

@property (nonatomic,strong)SFSpeechRecognizer *recognizer;
@property(nonatomic,strong)SFSpeechAudioBufferRecognitionRequest * recognitionRequest;
@property(nonatomic,strong)SFSpeechRecognitionTask * recognitionTask ;
@property (nonatomic,strong)AVAudioEngine * audioEngine;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"];
    _recognizer = [[SFSpeechRecognizer alloc] initWithLocale:locale];
    
    //把语音识别的代理设置为 self
    _recognizer.delegate = self;

    //发送语音认证请求(首先要判断设备是否支持语音识别功能)
    [self requestJurisdiction];
    
    self.audioEngine = [[AVAudioEngine alloc]init];

}

- (void)dealloc {
    
    [self.recognitionTask cancel];
    
    self.recognitionTask = nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)startBtnPress:(id)sender {
    if ([self.audioEngine isRunning]) {
        [self.audioEngine stop];
        [self.recognitionRequest endAudio];
    }else{
        [self startRecording];
        self.stateLb.text = @"录音进行中。。。";
    }
}

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


//当语音识别操作可用性发生改变时会被调用
- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available{
    if (available) {
        
    }else{
        
    }
}


@end
