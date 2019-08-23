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

namespace Gstampnote.Widgets {
    public class Item : Gtk.Box {
        Gtk.Label date;
        Gtk.Label count;

        public Item (DateTime datetime, int item_count) {
            date = new Gtk.Label ("");
            date.halign = Gtk.Align.START;

            count = new Gtk.Label ("");
            count.halign = Gtk.Align.END;

            pack_start (date, true, true, 0);
            pack_end (count, false, false, 0);

            update(datetime, item_count);
        }

        construct {
            orientation = Gtk.Orientation.HORIZONTAL;
            valign = Gtk.Align.START;
        }

        public void update (DateTime datetime, int item_count) {
            date.set_label(datetime.format ("%A %B %d, %Y"));
            count.set_label(@"$item_count Notes");
        }
    }

	public class SideBar : Gtk.Box {
        private Gtk.Button add_note;
        private Gtk.Calendar calendar;
        private Item item_box;

        private Models.Summary summary;

        public signal void selection_changed (DateTime datetime, Gee.ArrayList<Models.Note> notes);

        public SideBar () {
            summary = new Models.Summary ();
            summary.add_note (new Models.Note (1565521809, 
"""Productivity varies in any field, but there are a few in which it varies so much. The variation between programmers is so great that it becomes a defference in kind. I don't think this is something intrisic to programming though. In every field technology magnifies differences in productivity. I think what's happening in programming is just that we have a lot of technological leverage. But in every field the lever is getting longer , so the variation we see is something that more and more fields will see as time goes on. And the success of companies and countries, will depend incresingly on how they deal with it. """
            ));

            summary.add_note (new Models.Note (2147483647, 
"""They're finally working the way people are meant to"""
            ));

            calendar = new Gtk.Calendar();
            calendar.day_selected.connect(() => {
                var datetime = get_calendar_date_as_datetime();
                
                var notes = summary.find_notes_for_day (datetime);
                //  add_note.set_label(@"Notes: $(notes.size)");
                item_box.update(datetime, notes.size);
                selection_changed (datetime, notes);
            });

            calendar.month_changed.connect(() => {
                calendar.clear_marks();
                var datetime = get_calendar_date_as_datetime();
                
                foreach (var date in summary.find_notes_for_month(datetime)) {
                    calendar.mark_day(date);
                }
            });

            item_box = new Item (new DateTime.now_local(), 0);

            var btn_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);

            add_note = new Gtk.Button.from_icon_name ("list-add");
            add_note.width_request = 50;
            add_note.height_request = 25;
            add_note.clicked.connect (() => {
                var today = new GLib.DateTime.now_local();

                calendar.select_day (today.get_day_of_month());
                calendar.select_month ((today.get_month() - 1), today.get_year());
                calendar.day_selected ();
            });

            btn_box.add(add_note);

            pack_start(calendar, false, false, 5);
            pack_start(item_box, true, true, 0);
            pack_end(btn_box, false, false, 5);
        }

        construct {
            orientation = Gtk.Orientation.VERTICAL;
            width_request = 265;
            margin = 5;
        }

        public DateTime get_calendar_date_as_datetime() {
            uint day;
            uint month;
            uint year;
            
            calendar.get_date (out year, out month, out day);
            //  add_note.set_label(@"Notes: $year, $month, $day");

            return new DateTime.local ((int) year, (int) (month + 1), (int) day, 0, 0, 0d);
        }
	}
}
