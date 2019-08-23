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

namespace Gstampnote.Models {
  
    public class Summary {
        public Gee.List<Models.Note> notes { get; private set; }

        public Summary () {
            this.notes = new Gee.LinkedList<Models.Note>();
        }

        public void add_note (Models.Note note) {
            notes.add(note);
        }

        public Gee.ArrayList<Models.Note> find_notes_for_day(DateTime datetime) {
            var notes_for_day = new Gee.ArrayList<Models.Note> ();

            foreach (var note in notes) {
                if(note.timestamp.get_year() == datetime.get_year() && 
                    note.timestamp.get_month() == datetime.get_month() && 
                    note.timestamp.get_day_of_month() == datetime.get_day_of_month()) {

                        notes_for_day.add (note);
                    }
            }

            return notes_for_day;
        }

        public Gee.ArrayList<int> find_notes_for_month(DateTime datetime) {
            var dates_with_notes = new Gee.ArrayList<int> ();

            foreach (var note in notes) {
                if(note.timestamp.get_year() == datetime.get_year() && 
                    note.timestamp.get_month() == datetime.get_month()) {

                        dates_with_notes.add (note.timestamp.get_day_of_month());
                    }
            }

            return dates_with_notes;
        }
    }

}