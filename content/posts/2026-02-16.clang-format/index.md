+++
title = "Clang-format is good enough"
description = "An argument in favour of automated code formatting"
taxonomies.tags = ["software"]
date = "2026-02-15"
+++

Recently I have been in a number of arguments whether automated code formatting is good or bad. Specifically, opposition argues clang-format sometimes produces weird-looking code that is sometimes worse than it was originally. So here's some arguments I use in favour of using clang-format or any other formatter in general  

# Plain consistency

Manually-formatted code can look better if everyone agrees on a style, but for a solo project there is no one to actually correct you if you overlook an improperly positioned pointer or reference character. Especially if you battle with a formatter built-into your IDE that cannot be configured. Yikes!  

# Typing speed

You can type unformatted code into a single line without any unnecessary whitespace, then hit Ctrl+S and have your entire code unwrapped into a nice formatted bunch of lines. Reducing the amount of characters you have to type always makes typing faster (not that it matters with my average typing speed of like 120 WPM on good days but still a reduction in characters typed reduces the time needed to write what you need to write):

```cpp
// Before saving
s_camera.set_projection_perspective(float(M_PI)/2.0f,640.0f/480.0f,0.1f,100.0f);s_camera.set_look(Eigen::Vector3f(sval,0.5f,cval),Eigen::Vector3f::Zero());s_camera.update();
```
```cpp
// After saving
s_camera.set_projection_perspective(float(M_PI) / 2.0f, 640.0f / 480.0f, 0.1f, 100.0f);
s_camera.set_look(Eigen::Vector3f(sval, 0.5f, cval), Eigen::Vector3f::Zero());
s_camera.update();
```

# Teamwork and code review

Initially, the software we develop at work, did not use any kind of automatic code formatting. Instead, code style was essentially agreed on; the style itself was very inconsistent with pointer/reference alignment (and from what I can see we're not the only team that had that style) and was practically impossible to clang-format:  

```cpp
static ReturnType& functionName(float *pointerArgument, float &reference) {
  ASSERT_NOT_NULL(pointerArgument);

  std::vector<int*> pointerVector;
  pointerVector.push_back(reinterpret_cast<int*>(pointerArgument));

  const float *referenceAddress = &reference;
  ReturnType result;

  if(pointerArgument == referenceAddress) {
    result = doSomething(referenceAddress);
  } else if(pointerArgument == nullptr) {
    result = doSomethingElse(42);
  } else {
    result = doOtherThings(1337);
  }

  return result;
}
```

While this style was very compact, with the rising size of the source code, long if-elseif-else constructions started to appear and we couldn't really do anything with those:  

```cpp
if(metaObject->inherits(&SomeObject1::staticMetaObject)) {
  doSomethingForSomeObject1(metaObject, someArgument, otherArgument);
  doSomethingCommon(testArgument, strangeArgument, whatever);
  doSomethingElseForSO1(42, testArgument, strangeArgument, whatever);
} else if(metaObject->inherits(&SomeObject2::staticMetaObject)) {
  doSomethingForSomeObject2(metaObject, someArgument, otherArgument);
  doSomethingCommonButDifferent(testArgument, strangeArgument, whatever);
  auto object = getObjectById(id, metaObject);
  ASSERT(object && object->is<SomeObject2>());
  doSomethingElseForSO2(1337);
} else if(metaObject->inherits(&SomeObject3::staticMetaObject)) {
  auto value = getDoubleFromSomewhere(someArgument, otherArgument);
  ASSERT(qIsFinite(value) && value >= 0.0 && value <= 10.0);
  doSomethingForSomeObject3(metaObjectm testArgument, strangeArgument);
  doSomethingCommonVeryDifferent(testArgument, strangeArgument, whatever);
  doSomethingElseForSO3(42, testArgument, strangeArgument, whatever);
} else if(metaObject->inherits(&OtherObjectType::staticMetaObject)) {
  doSomethingForOtherObjectType(metaObject, someArgument, otherArgument);
  auto distance = plane.signedDistance(point);
  ASSERT(qIsFinite(distance) && distance > 10.0);
  doSomethingCommonASDASDASGFASD(testArgument, strangeArgument, whatever);
  doSomethingElseForSO1(42, testArgument, strangeArgument, whatever);
}
```

> **Question:** can you look at this code once and know for certain where each conditional block ends and a new one begins? Me neither! And neither was like every other programmer in the team!  

Eventually we started noticing that like 90% of all the time we spent on cross-code-review was on code style analysis and not scrutinizing the actual algorithmic content of the code. Essentially, we were wasting time.  

After a month of complaining, we finally agreed on a style that is both supported by clang-format (pointer and reference alignment) and reduces visual noise by separating logical blocks more:  

```cpp
static ReturnType& functionName(float* pointerArgument, float& reference)
{
  ASSERT_NOT_NULL(pointerArgument);

  std::vector<int*> pointerVector;
  pointerVector.push_back(reinterpret_cast<int*>(pointerArgument));

  const float* referenceAddress = &reference;
  ReturnType result;

  if(pointerArgument == referenceAddress) {
    result = doSomething(referenceAddress);
  }
  else if(pointerArgument == nullptr) {
    result = doSomethingElse(42);
  }
  else {
    result = doOtherThings(1337);
  }

  return result;
}
```

```cpp
if(metaObject->inherits(&SomeObject1::staticMetaObject)) {
  doSomethingForSomeObject1(metaObject, someArgument, otherArgument);
  doSomethingCommon(testArgument, strangeArgument, whatever);
  doSomethingElseForSO1(42, testArgument, strangeArgument, whatever);
}
else if(metaObject->inherits(&SomeObject2::staticMetaObject)) {
  doSomethingForSomeObject2(metaObject, someArgument, otherArgument);
  doSomethingCommonButDifferent(testArgument, strangeArgument, whatever);
  auto object = getObjectById(id, metaObject);
  ASSERT(object && object->is<SomeObject2>());
  doSomethingElseForSO2(1337);
}
else if(metaObject->inherits(&SomeObject3::staticMetaObject)) {
  auto value = getDoubleFromSomewhere(someArgument, otherArgument);
  ASSERT(qIsFinite(value) && value >= 0.0 && value <= 10.0);
  doSomethingForSomeObject3(metaObjectm testArgument, strangeArgument);
  doSomethingCommonVeryDifferent(testArgument, strangeArgument, whatever);
  doSomethingElseForSO3(42, testArgument, strangeArgument, whatever);
}
else if(metaObject->inherits(&OtherObjectType::staticMetaObject)) {
  doSomethingForOtherObjectType(metaObject, someArgument, otherArgument);
  auto distance = plane.signedDistance(point);
  ASSERT(qIsFinite(distance) && distance > 10.0);
  doSomethingCommonASDASDASGFASD(testArgument, strangeArgument, whatever);
  doSomethingElseForSO1(42, testArgument, strangeArgument, whatever);
}
```

So we essentially traded code compactness for ability to figure out where each logical block ends without adding empty lines everywhere. So far the amount of style remarks during code review has decreased dramatically. The only places that still require a comment are commented out code and expressions that are so long and complex they make clang-format go nuts and produce a horrid mess:  

```cpp
double angs =
  1.0
    - pow((projectedPoint - crossPoints[i]).dot(linear.col(0)) / ((projectedPoint - crossPoints[i]).norm() * linear.col(0).norm()),
      2);
```

But we agreed that if your code gets formatted like that, it's easier to just split the expression into multiple lines and variable declarations (besides, they are going to be optimized out into one anyways) than trying to change clang-format because of a single long line...  
