import ceramic.Scene;
import ceramic.Quad;
import ceramic.Color;

class Credits extends Scene {
    var hl:Quad;
    var cl:Quad;
    var sep:Quad;
    var ending = false;
    override function preload() {
        assets.add(Images.CERAMIC);
        assets.add(Images.HAXE);
    }
    override function create() {
        super.create();

        hl = new Quad();
        cl = new Quad();
        sep = new Quad();

        hl.texture = assets.texture(Images.HAXE);
        hl.size(600, 400);
        hl.anchor(0.5, 0.5);
        hl.pos(width / 2 - 130, height / 2);
        hl.alpha = 0;

        cl.texture = assets.texture(Images.CERAMIC);
        cl.size(200, 280);
        cl.anchor(0.5, 0.5);
        cl.pos(width / 2 + 130, height / 2);
        cl.alpha = 0;

        sep.color = Color.WHITE;
        sep.size(3, 290);
        sep.anchor(0.5, 0.5);
        sep.pos(width / 2, height / 2);
    }
    override function update(dt:Float) {
        if (!ending) {
            showLogos(dt);
        } else {
            if (sep.alpha <= 0) {
                app.scenes.main = new MainMenu();
            } else {
                hideAll(dt);
            }
        }
    }
    function showLogos(dt:Float) {
        if (cl.alpha >= 1) {
            ending = true;
            return;
        }
        if (hl.alpha < 1) {
            hl.alpha += 0.3 * dt;
        }
        if (cl.alpha < 1 && hl.alpha >= 1) {
            cl.alpha += 0.3 * dt;
        }
    }
    function hideAll(dt:Float) {
        hl.alpha -= 0.3 * dt;
        cl.alpha -= 0.3 * dt;
        sep.alpha -= 0.3 * dt;
    }
}