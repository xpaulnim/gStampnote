/* Content.vala
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
    public class TimestampedNote : Gtk.Box {
        public Models.Note note { get; set; }

        public TimestampedNote (Models.Note note) {
            this.note = note;

            var time_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            time_box.margin_end = 10;

            var time = new Gtk.Label (note.timestamp.format ("%I:%M %p"));
            time_box.add(time);
            
            var note_lbl = new Gtk.Label (note.note);
            note_lbl.wrap = true;
            note_lbl.wrap_mode = Pango.WrapMode.WORD;

            add (time_box);
            add (note_lbl);
        }

        construct {
            orientation = Gtk.Orientation.HORIZONTAL;
            hexpand = true;
        }
    }

    public class Content : Gtk.Box {

        Gtk.Label day;
        ListStore notes_list;
        Gtk.FlowBox flowbox;
        Gtk.TextView text_entry;
        Gtk.Button add_note;
        Gtk.Label current_date;

        public Content() {
            day = new Gtk.Label ("");
            day.halign = Gtk.Align.START;
            day.margin_start = 8;
            day.margin_top = 3;
            day.margin_bottom = 3;

            var seperator = new Gtk.Separator (Gtk.Orientation.VERTICAL);
            seperator.visible = true;
            seperator.no_show_all = false;

            notes_list = new ListStore(typeof (Models.Note));

            flowbox = new Gtk.FlowBox ();
            flowbox.bind_model (notes_list, (note) => {
                return new TimestampedNote (note as Models.Note);
            });
            flowbox.valign = Gtk.Align.START;
            flowbox.selection_mode = Gtk.SelectionMode.NONE;
            flowbox.margin_start = 5;
            flowbox.margin_top = 2;
            flowbox.margin_bottom = 2;
            
            var scroll = new Gtk.ScrolledWindow (null, null);
            scroll.add(flowbox);

            var scrolled = new Gtk.ScrolledWindow (null, null);
            scrolled.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
            scrolled.height_request = 100;

            text_entry = new Gtk.TextView ();
            text_entry.set_wrap_mode(Gtk.WrapMode.WORD);
            text_entry.height_request = 250;
            text_entry.top_margin = 5;
            text_entry.bottom_margin = 5;
            text_entry.left_margin = 5;
            text_entry.right_margin = 5;
            
            scrolled.add (text_entry);

            add_note = new Gtk.Button.from_icon_name ("document-send");
            current_date = new Gtk.Label(new DateTime.now().format ("%A %B %d, %Y - %T %Z"));

            GLib.Timeout.add (1000, () => {
                current_date.set_label(new DateTime.now().format ("%A %B %d, %Y - %T %Z"));
                return true;
            });
            
            var entry_save_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);

            entry_save_box.pack_start(current_date, false, true, 0);
            entry_save_box.pack_end(add_note, false, true, 0);

            var add_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
            add_box.margin = 8;
            add_box.pack_start(scrolled, true, true, 0);
            
            add_box.pack_end(entry_save_box, false, false, 0);

            pack_start (day, false, false, 0);
            pack_start (seperator, false, false, 0);
            pack_start (scroll, true, true, 0);
            
            pack_end (add_box, false, false, 0);
        }

        construct {
            orientation = Gtk.Orientation.VERTICAL;
            margin = 0;
            hexpand = true;
        }

        public void show_note (DateTime timestamp, Gee.ArrayList<Models.Note> notes) {
            day.label = timestamp.format ("%B %d, %Y");

            notes_list.remove_all ();

            foreach (var note in notes) {
                notes_list.append(note);
            }

            show_all ();
        }
    }
}
