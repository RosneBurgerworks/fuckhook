#pragma once

#include "common.hpp"
#include "micropather.h"
#include "pwd.h"

namespace nav
{
extern bool init;
extern bool ReadyForCommands;
extern std::vector<CNavArea> areas;
std::vector<Vector> findPath(Vector loc, Vector dest);
bool NavTo(Vector dest);
bool Prepare();
void CreateMove();
}
