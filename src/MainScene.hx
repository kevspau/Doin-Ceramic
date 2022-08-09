package;

import js.html.audio.StereoPannerNode;
import ceramic.Text;
import ceramic.Quad;
import ceramic.Scene;

class MainScene extends Scene {

    var logo:Quad;

    override function preload() {

        // Add any asset you want to load here

        assets.add(Images.CERAMIC);

    }

    override function create() {

        // Called when scene has finished preloading

        // Display logo
        logo = new Quad();
        logo.texture = assets.texture(Images.CERAMIC);
        logo.anchor(0.5, 0.5);
        logo.pos(width * 0.5, height * 0.5);
        logo.scale(0.001);
        logo.alpha = 0;
        var text = new Text();
        text.content = "Scene 2";
        text.pointSize = 40;
        text.anchor(0.5, 0.5);
        text.pos(width * 0.5, height * 0.3);
        add(text);
        add(logo);

        // Create some logo scale "in" animation
        logo.tween(ELASTIC_EASE_IN_OUT, 1, 0.001, 1.0, function(value, time) {
            logo.alpha = value;
            logo.scale(value);
        });
        logo.onPointerDown(this, info -> {
            app.scenes.main = new MainMenu();
        });

        // Print some log
        log.success('Hello from ceramic :)');

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
