package;

import js.html.audio.StereoPannerNode;
import ceramic.Text;
import ceramic.Quad;
import ceramic.Scene;
import ceramic.ScanCode;

class MainScene extends Scene {

    var plr:Quad;

    override function preload() {

        // Add any asset you want to load here

        assets.add(Images.CERAMIC);
        assets.add(Images.DAYDREAM);

    }

    override function create() {

        // Called when scene has finished preloading

        // Display logo
        plr = new Quad();
        plr.size(50, 50);
        plr.pos(width / 2, height / 2);
        plr.anchor(0.5, 0.5);
        input.onKeyDown(this, key -> {
            switch (key.scanCode) {
                case LEFT:
                    plr.pos(plr.x - 10, plr.y);
                case RIGHT:
                    plr.pos(plr.x + 10, plr.y);
                case UP:
                    plr.pos(plr.x, plr.y - 10);
                case DOWN:
                    plr.pos(plr.x, plr.y + 10);
                case _:
                    return;
            }
        });
    }

    override function update(delta:Float) {

        // Here, you can add code that will be executed at every frame

    }

    override function resize(width:Float, height:Float) {

        // Called everytime the scene size has changed

    }

    override function destroy() {

        // Perform any cleanup before final destroy

        super.destroy();

    }

}
//TODO make plr class and make it moveable based on dt
class Player extends Quad {
    public function init(w, h:Int) {
        size(w, h);
        anchor(0.5, 0.5);
    }
    public function update(dt:Float) {

    }
}
