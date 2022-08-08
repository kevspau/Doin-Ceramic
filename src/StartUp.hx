import ceramic.Text;
import ceramic.Quad;
import ceramic.Color;
import ceramic.Scene;
import ceramic.TouchInfo;
using ceramic.VisualTransition;

class StartUp extends Scene {
    var q = new Quad();
    override function preload() {
        assets.add(Images.CERAMIC);
        assets.add(Fonts.DAYDREAM);
    }
    override function create() {
        log.debug("Creating Square...");
        var t = new Text();
        t.content = "Scene 1";
        t.pos(width * 0.5, height * 0.3);
        t.anchor(0.5, 0.5);
        t.pointSize = 40;
        t.align = CENTER;
        t.font = assets.font(Fonts.DAYDREAM);
        add(t);

        q.texture = assets.texture(Images.CERAMIC);
        q.pos(width * 0.5, height * 0.5);
        q.anchor(0.5, 0.5);
        add(q);

        q.onPointerDown(this, info -> {
            app.scenes.main = new MainScene();
        });
    }

    override function update(delta:Float) {
        q.rotation += delta * 50;
    }

    function logoClick(info:TouchInfo) {
        q.transition(QUAD_EASE_IN_OUT, 0.4, q -> {
            q.x = width * (0.1 + Math.random() * 0.8);
            q.y = height * (0.1 + Math.random() * 0.8);
            q.scaleX = 0.5 * (0.25 + 0.75 * Math.random());
            q.scaleY = q.scaleX;
            q.rotation = 360 * Math.random();
        });
    }

    override function destroy() {
        super.destroy();
    }
}