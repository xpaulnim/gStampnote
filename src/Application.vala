/* Application.vala
 *
 * Copyright 2019 Paul Nimusiima
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
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace Gstampnote {
    public class Application : Gtk.Application {
        public bool running = false;
        public Window window;

        construct {
            // application_id = "com.github.xpaulnim.gstampnote";
        }

        public override void activate () {
            if (!running) {
                window = new Window(this);
                this.add_window(window);

                running = true;

                return;
            }

            window.show_app ();
        }

        public static int main(string[] args) {
            return new Application().run(args);
        }
    }
}
