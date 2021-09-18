/* This is a template to start C/C++ projects from. You _are_ allowed to remove
 * this copyright notice, even though it says otherwise. That is because I use
 * this notice to copy it into every source file, but it _does not_ apply to
 * this sample project! If you see this copyright notice in any other context,
 * you're legally required to follow it, though. Beware!
 *
 * Sample Project Copyright (C) 2021 Daniel Schuette
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */
#include "common.hh"

void f(void)
{
    fprintf(stderr, "goodbye sample\n");
    return;
}

int main(void)
{
    fprintf(stderr, "hello sample\n");
    f();

    return 0;
}
