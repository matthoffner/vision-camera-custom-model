#import <VisionCamera/FrameProcessorPlugin.h>
#import <VisionCamera/Frame.h>
#import <MLKit.h>

// Example for an Objective-C Frame Processor plugin

@interface ImageLabelerPlugin : NSObject

+ (MLKImageLabeler*) labeler;


@end

@implementation ImageLabelerPlugin


+ (MLKImageLabeler*) labeler {
  static MLKImageLabeler* labeler = nil;

  if (labeler == nil) {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"model" ofType:@"tflite"];
    MLKLocalModel *localModel = [[MLKLocalModel alloc] initWithPath:path];

    MLKCustomImageLabelerOptions *options = [[MLKCustomImageLabelerOptions alloc] initWithLocalModel:localModel];
    options.confidenceThreshold = @(0.0);
    labeler = [MLKImageLabeler imageLabelerWithOptions:options];
  }
  return labeler;
}

static inline id labelImage(Frame* frame, NSArray* arguments) {

  MLKVisionImage *image = [[MLKVisionImage alloc] initWithBuffer:frame.buffer];
  image.orientation = frame.orientation;

  NSError* error = nil;
  NSArray<MLKImageLabel*>* labels = [[ImageLabelerPlugin labeler] resultsInImage:image error:&error];

  if(error){
    NSLog(@"Error finding Labels: %@", error);
  } else {
    NSLog(@"No Error: %@", error);
  }

  NSMutableArray* results = [NSMutableArray arrayWithCapacity:labels.count];
  for (MLKImageLabel* label in labels) {
    [results addObject:@{
      @"label": label.text,
      @"confidence": [NSNumber numberWithFloat:label.confidence]
    }];
  }

  return results;
}

VISION_EXPORT_FRAME_PROCESSOR(labelImage)

@end
