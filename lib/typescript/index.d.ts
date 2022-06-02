import type { Frame } from 'react-native-vision-camera';
interface ImageLabel {
    /**
     * A label describing the image, in english.
     */
    label: string;
    /**
     * A floating point number from 0 to 1, describing the confidence (percentage).
     */
    confidence: number;
}
/**
 * Returns an array of matching `ImageLabel`s for the given frame.
 *
 * This algorithm executes within **~60ms**, so a frameRate of **16 FPS** perfectly allows the algorithm to run without dropping a frame. Anything higher might make video recording stutter, but works too.
 */
export declare function labelImage(frame: Frame): ImageLabel[];
export {};
