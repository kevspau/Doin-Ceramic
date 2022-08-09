import ceramic.Text;
import ceramic.Quad;
import ceramic.Color;
import ceramic.Scene;
import ceramic.TouchInfo;
using ceramic.VisualTransition;

class MainMenu extends Scene {
    var q = new Quad();
    var sceneText = new Text();
    var title = new Text();
    override function preload() {
        assets.add(Images.DOINGIT);
        assets.add(Fonts.DAYDREAM);
        assets.add(Fonts.GRAPE_SODA);
    }
    override function create() {
        //add scene name
        sceneText.content = "Main Menu";
        sceneText.pointSize = 15;
        sceneText.align = CENTER;
        sceneText.font = assets.font(Fonts.DAYDREAM);
        sceneText.pos(width * 0.1, height * 0.1);
        add(sceneText);

        title.content = "Doin' It";
        title.align = CENTER;
        title.pointSize = 100;
        title.anchor(0.5, 0.5);
        title.pos(width * 0.5, height * 0.5);
        title.font = assets.font(Fonts.GRAPE_SODA);
        add(title);
        var options = new MenuOptions(this, assets.font(Fonts.GRAPE_SODA));
        //add(options);
        //options.size(width, height);
        //options.start();
        log.debug(options.width);
        log.debug(options.height);
        q.onPointerDown(this, info -> {
            app.scenes.main = new MainScene();
        }); 
    }

    override function update(delta:Float) {
        sceneText.pos(10, 10);
        title.pos(width * 0.5, height * 0.5);
    }

    override function destroy() {
        super.destroy();
    }
    override function resize(width, height:Float) {
        log.debug(width);
        log.debug(height);
    }
}
class MenuOptions extends ceramic.Visual {
    var Begin: Text;
    var Credits: Text;
    public function new(scene:Scene, font:ceramic.BitmapFont) {
        super();
        Begin = new Text();
        Begin.content = "Begin";
        Begin.font = font;
        Begin.color = Color.CYAN;
        Begin.anchor(0.5, 0.5);
        Begin.scale(2.5, 2.5);

        Credits = new Text();
        Credits.content = "Credits";
        Credits.font = font;
        Credits.color = Color.GRAY;
        Credits.anchor(0.5, 0.5);
        Credits.scale(2, 2);
        scene.add(this);
        this.size(scene.width, scene.height);

        Credits.pos(width * 0.6, height * 0.8);
        add(Credits);
        Begin.pos(width * 0.4, height * 0.8);
        add(Begin);
    }
    public function start() {

    }
}