/* Window.vala
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

	public class Window : Gtk.ApplicationWindow {
	    private Widgets.Content notes_body_view;
		private Widgets.SideBar sidebar;
		private Controller controller;

		public Window (Gtk.Application app) {
			Object (application: app);

			show_app ();
		}

		public void show_app() {
	        var provider = new Gtk.CssProvider ();
	        provider.load_from_resource ("/com/github/xpaulnim/gstampnote/stylesheet.css");
	        Gtk.StyleContext.add_provider_for_screen(Gdk.Screen.get_default(), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

            var grid = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            grid.width_request = 950;
            grid.height_request = 500;

	        var headerbar = new Widgets.HeaderBar ();
	        set_titlebar (headerbar);

	        notes_body_view = new Widgets.Content ();
            sidebar = new Widgets.SideBar ();

	        var seperator = new Gtk.Separator (Gtk.Orientation.VERTICAL);
            seperator.visible = true;
			seperator.no_show_all = false;
			
			controller = new Controller(this, sidebar, notes_body_view);

		    grid.add (sidebar);
		    grid.add (seperator);
		    grid.add (notes_body_view);

            add (grid);

	        show_all ();
            present ();
	    }
	}
}
