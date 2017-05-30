#ifndef GAME_RESOURCES_CONFIG_HPP
#define GAME_RESOURCES_CONFIG_HPP

#include "AppMacro.hpp"

NS_GAME_BEGIN
enum class ResourcesPackage {
    /// Small resources package, x1 resolution.
    Small,

    /// Medium resources package, x2 resolution.
    Medium,

    /// Large resources package, x4 resolution.
    Large
};

/// Gets the resources package type for the current build.
/// @param designedWidth The width of the designation resolution.
/// @param designedHeight The height of the designation resolution.
ResourcesPackage getResourcesPackage(float designedWidth, float designedHeight);
NS_GAME_END

#endif /* GAME_RESOURCES_CONFIG_HPP */
