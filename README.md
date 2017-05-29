# Cocos2d-x-3.15 Lite with Pod

## Changes

- Update tinyxml2 to 4.0.1
- Remove 3D particles and cocostudio.

## Drawbacks

- Cannot use `⌘ + ⇧ + O` to search for source files in Xcode.

## Integration

- Modify `Podfile`

```
pod 'cocos2d-x', :git => 'https://github.com/Senspark/cocos2d-x-3.15'
```

- Note: installing this pod will automatically overrides `~/.lldbinit-Xcode` to set the source files for debugging.