//
//  CallRecordViewController.m
//  CallRecord
//
//  Created by manman on 2017/4/23.
//  Copyright © 2017年 manman. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "CallRecordViewController.h"
#import "TimeConvert.h"


#define kAudioFileName @test.caf

@interface CallRecordViewController ()

@property (nonatomic,strong) AVAudioRecorder *audioRecorder; //音频录音机
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;     //音频播放器
@property (nonatomic,strong) NSTimer *timer;            //录音监控

//@property (weak, nonatomic) IBOutlet UIProgressView *audioPower;

@end


@implementation CallRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"电话录音";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [TimeConvert GetLocalCurrentTime:@""];
    
    
    //[self setAudioSession];
    
    
}

/**
 *  设置音频会话
 */
-(void)setAudioSession{
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    //设置为播放和录音状态，以便可以在录制完之后播放录音
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
}

/**
 *  录音文件设置
 *
 *  @return 返回录音设置
 */
- (NSDictionary *)getAudioSetting
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];  //设置录音格式
    [dic setObject:@(8000) forKey:AVSampleRateKey];                 //设置采样率
    [dic setObject:@(1) forKey:AVNumberOfChannelsKey];              //设置通道，这里采用单声道
    [dic setObject:@(8) forKey:AVLinearPCMBitDepthKey];             //每个采样点位数，分为8，16，24，32
    [dic setObject:@(YES) forKey:AVLinearPCMIsFloatKey];            //是否使用浮点数采样
    return dic;
}

/**
 *  录音存储路径
 *
 *  @return 返回存储路径
 */
- (NSURL *)getSavePath
{
    NSString *url = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask,YES) lastObject];
    NSString *audioFileName = [TimeConvert GetLocalCurrentTime:@""];
    
    url = [url stringByAppendingPathComponent:audioFileName];
    return [NSURL URLWithString:url];
}


#pragma mark -
#pragma mark - AVAudioRecorderDelegate
//录音成功
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    if (![self.audioPlayer isPlaying]) {
        [self.audioPlayer play];
    }
}
//录音失败
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    
}

- (void)audioPowerChange{
    [self.audioRecorder updateMeters];  //更新测量值
    float power = [self.audioRecorder averagePowerForChannel:1]; //取得第一个通道的音频，注意音频强度范围时-160到0
    //self.audioPower.progress = (1.0/160)*(power+160);
}

/**
 *  点击录音按钮
 *
 *  @param sender 录音按钮
 */
- (IBAction)startRecord:(id)sender {
    
    if (![self.audioRecorder isRecording]) {
        [self.audioRecorder record];
        self.timer.fireDate = [NSDate distantPast];
    }
}


/**
 *  点击取消录音按钮
 *
 *  @param sender 取消录音按钮
 */
- (IBAction)cancelRecord:(id)sender {
    self.audioRecorder.delegate = nil;
    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder stop];
    }
    self.audioRecorder = nil;
}

/**
 *  点击暂定按钮
 *
 *  @param sender 暂停按钮
 */
- (IBAction)pause:(id)sender {
    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder pause];
        self.timer.fireDate = [NSDate distantFuture];
    }
}

/**
 *  点击恢复按钮
 *  恢复录音只需要再次调用record，AVAudioSession会帮助你记录上次录音位置并追加录音
 *
 *  @param sender 恢复按钮
 */
- (IBAction)goon:(id)sender {
    [self startRecord:nil];
}

/**
 *  点击停止按钮
 *
 *  @param sender 停止按钮
 */
- (IBAction)stop:(id)sender {
    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder stop];
        self.timer = [NSDate distantFuture];
    }
}

/**
 *  点击播放按钮
 *
 *  @param sender 播放按钮
 */
- (IBAction)play:(id)sender {
    
    if (![self.audioPlayer isPlaying]) {
        [self.audioPlayer play];
    }
}




- (AVAudioRecorder *)audioRecorder
{
    if (!_audioRecorder) {
        NSError *error = nil;
        _audioRecorder = [[AVAudioRecorder alloc] initWithURL:[self getSavePath] settings:[self getAudioSetting] error:&error];
        _audioRecorder.delegate = self;
        _audioRecorder.meteringEnabled = YES; //是否启用录音测量，如果启用录音测量可以获得录音分贝等数据信息
        if (error) {
            //NSLog(@创建录音机对象发生错误:%@,error.localizedDescription);
            return nil;
        }
    }
    return _audioRecorder;
}

- (AVAudioPlayer *)audioPlayer
{
    if (!_audioPlayer) {
        NSError *error = nil;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[self getSavePath] error:&error];
        if (error) {
           // NSLog(@创建音频播放器对象发生错误:%@,error.localizedDescription);
            return nil;
        }
    }
    return _audioPlayer;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
