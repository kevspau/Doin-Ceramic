package;

import ceramic.Pool;
import js.html.audio.StereoPannerNode;
import ceramic.Text;
import ceramic.Quad;
import ceramic.Scene;
import ceramic.ScanCode;

class MainScene extends Scene {

    var plr:Player;

    override function preload() {

        // Add any asset you want to load here

        assets.add(Images.CERAMIC);
        assets.add(Images.DAYDREAM);

    }

    override function create() {

        // Called when scene has finished preloading

        // Display logo
        plr = new Player(100, 100);
        input.onKeyDown(this, key -> {
            switch (key.scanCode) {
                case LEFT:
                    plr.x -= 50 * app.realDelta;
                case RIGHT:
                    plr.x += 50 * app.realDelta;
                case UP:
                    plr.y -= 50 * app.realDelta;
                case DOWN:
                    plr.y += 50 * app.realDelta;
                case _:
                    return;
            }
        });

        this.onPointerDown(this, plr.shoot);
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
    var bulletPool = new Pool<Quad>();
    public function new(w, h:Int) {
        super();
        size(w, h);
        anchor(0.5, 0.5);
    }
    public function update(dt:Float) {

    }
    public function shoot(i:ceramic.TouchInfo) {
        //if LMB is clicked
        if (i.buttonId == 1) {

        }
    }
}
