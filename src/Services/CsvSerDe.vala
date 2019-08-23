/* CsvSerDe.vala
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
    public class CsvSerDe {
        public signal void notes_loaded (List<Models.Note> notes);

        public void load_notes_from_file (string filepath) {
            try {
                var file = File.new_for_path (filepath);

                if (file.query_exists ()) {
                    var dis = new DataInputStream (file.read ());

                    for (string line = dis.read_line (); line != null; 
                                    line = dis.read_line()) {

                        deserialize_line (line);
                    }
                }
            } catch (Error e) {
                warning ("Error during loading settings: %s\n", e.message);
            }
        }

        private Models.Note deserialize_line (string line) {
            var note = line.split (",");

            return new Models.Note ((int64) note[0], note[1]);
        }
    }
}