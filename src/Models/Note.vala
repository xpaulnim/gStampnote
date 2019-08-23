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
    public class Note : Object {
        public DateTime timestamp { get; set; }
        public string note { get; set; }

        public Note (int64 timestamp, string note) {
            this.timestamp = new DateTime.from_unix_local(timestamp);
            this.note = note;
        }
    }
}