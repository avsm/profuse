(*
 * Copyright (c) 2014 David Sheets <sheets@alum.mit.edu>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 *)

open Ctypes
open Unsigned
open View

module Attr = struct
  type t
  let t : t structure typ = structure "Attr"
  let ( -:* ) s x = field t s x
  let ino       = "ino"       -:* uint64_t
  let size      = "size"      -:* uint64_t
  let blocks    = "blocks"    -:* uint64_t
  let atime     = "atime"     -:* uint64_t
  let mtime     = "mtime"     -:* uint64_t
  let ctime     = "ctime"     -:* uint64_t

  let crtime    = "crtime"    -:* uint64_t

  let atimensec = "atimensec" -:* uint32_t
  let mtimensec = "mtimensec" -:* uint32_t
  let ctimensec = "ctimensec" -:* uint32_t

  let crtimensec= "crtimensec"-:* uint32_t

  (* TODO: check order *)
  let mode      = "mode"      -:* uint32_t
  let nlink     = "nlink"     -:* uint32_t
  let uid       = "uid"       -:* uint32_t
  let gid       = "gid"       -:* uint32_t
  let rdev      = "rdev"      -:* uint32_t

  let flags     = "flags"     -:* uint32_t

  let () = seal t

  let ino_       = ino
  let size_      = size
  let blocks_    = blocks
  let atime_     = atime
  let mtime_     = mtime
  let ctime_     = ctime

  let crtime_    = crtime

  let atimensec_ = atimensec
  let mtimensec_ = mtimensec
  let ctimensec_ = ctimensec

  let crtimensec_= crtimensec

  let mode_      = mode
  let nlink_     = nlink
  let uid_       = uid
  let gid_       = gid
  let rdev_      = rdev

  let flags_     = flags

  let store ~ino ~size ~blocks
      ~atime ~mtime ~ctime ?(crtime=UInt64.zero)
      ~atimensec ~mtimensec ~ctimensec ?(crtimensec=UInt32.zero)
      ~mode ~nlink ~uid ~gid ~rdev ?(flags=UInt32.zero) mem =
    setf mem ino_        ino;
    setf mem size_       size;
    setf mem blocks_     blocks;
    setf mem atime_      atime;
    setf mem mtime_      mtime;
    setf mem ctime_      ctime;
    setf mem crtime_     crtime;
    setf mem atimensec_  atimensec;
    setf mem mtimensec_  mtimensec;
    setf mem ctimensec_  ctimensec;
    setf mem crtimensec_ crtimensec;
    setf mem mode_       mode;
    setf mem nlink_      nlink;
    setf mem uid_        uid;
    setf mem gid_        gid;
    setf mem rdev_       rdev;
    setf mem flags_      flags;
    ()

  let create ~ino ~size ~blocks
      ~atime ~mtime ~ctime ?(crtime=UInt64.zero)
      ~atimensec ~mtimensec ~ctimensec ?(crtimensec=UInt32.zero)
      ~mode ~nlink ~uid ~gid ~rdev ?(flags=UInt32.zero) () =
    let attr = make t in
    store ~ino ~size ~blocks
      ~atime ~mtime ~ctime ~crtime
      ~atimensec ~mtimensec ~ctimensec ~crtimensec
      ~mode ~nlink ~uid ~gid ~rdev ~flags attr;
    attr
end
