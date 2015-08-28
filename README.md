# MMX-PromiseKit

[![Build Status](https://travis-ci.org/sethsamuel/MMX-PromiseKit.svg?branch=master)](https://travis-ci.org/sethsamuel/MMX-PromiseKit)
[![Coverage Status](https://coveralls.io/repos/sethsamuel/MMX-PromiseKit/badge.svg?branch=master&service=github)](https://coveralls.io/github/sethsamuel/MMX-PromiseKit?branch=master)

#Installation

Include the PromiseKit category with `#import "MMX+PromiseKit.h"`.

#Usage

Most methods are a straightforward conversion from callbacks to promises. For example, to find channels with tag `foo`:

```
  [MMXChannel findByTags:[NSSet setWithArray:@[@"foo"]]]
  .then(^(NSNumber *count, NSArray* channels){
  });
```

For message methods that return a `messageID` before executing the callback, a promise is returned with the `messageID` as the first argument, and the completion promise as the second: 

```
  MMXMessage *messsage = [MMXMessage messageToChannel:someChannel messageContent:someContent];
  [message send]
  .then(^(NSString *messageID, PMKPromise *complete){
    //Do something with messageID
    return complete;
  })
  .then(^(){
    //Message is now sent
  });
```
