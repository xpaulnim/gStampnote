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

    public class Controller {
        public unowned Gtk.ApplicationWindow window;

        private Widgets.SideBar sidebar;
        private Widgets.Content content;

        public Controller (Gtk.ApplicationWindow window, Widgets.SideBar sidebar, 
                                    Widgets.Content content) {
            this.window = window;
            this.sidebar = sidebar;
            this.content = content;

            setup ();
        }

        private void setup () {
            sidebar.selection_changed.connect ((timestamp, notes) => {
                update_content (timestamp, notes);
            });
        }

        private void update_content (DateTime timestamp, Gee.ArrayList<Models.Note> notes) {
            content.show_note(timestamp, notes);
        }
    }

}