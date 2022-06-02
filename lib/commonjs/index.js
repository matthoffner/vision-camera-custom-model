"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.labelImage = labelImage;

/* globals __labelImage */

/**
 * Returns an array of matching `ImageLabel`s for the given frame.
 *
 * This algorithm executes within **~60ms**, so a frameRate of **16 FPS** perfectly allows the algorithm to run without dropping a frame. Anything higher might make video recording stutter, but works too.
 */
function labelImage(frame) {
  'worklet'; // @ts-expect-error Frame Processors are not typed.

  return __labelImage(frame);
}
//# sourceMappingURL=index.js.map