import ceramic.StateMachineBase;
import ceramic.Text;
import ceramic.Quad;
import ceramic.Color;
import ceramic.Scene;
import ceramic.TouchInfo;
using ceramic.VisualTransition;
class MainMenu extends Scene {
    var sceneText = new Text();
    var title = new Text();
    var square = new Quad();
    var options:MenuOptions;
    override function preload() {
        assets.add(Images.DOINGIT);
        assets.add(Fonts.DAYDREAM);
        assets.add(Fonts.GRAPE_SODA);
    }
    override function create() {
        super.create();
        options = new MenuOptions(this, assets.font(Fonts.GRAPE_SODA));
        add(options);
        square.size(20, 20);
        square.depth = -10;
        square.velocity(Math.random() * 0.4, Math.random() * 0.6);
        add(square);

        //add scene name
        sceneText.content = "Main Menu";
        sceneText.pointSize = 15;
        sceneText.align = CENTER;
        sceneText.font = assets.font(Fonts.DAYDREAM);
        sceneText.pos(width * 0.1, height * 0.1);
        add(sceneText);

        title.content = "Doin' It";
        title.align = CENTER;
        title.pointSize = 45;
        title.anchor(0.5, 0.5);
        title.pos(width * 0.5, 10);
        title.font = assets.font(Fonts.DAYDREAM);
        add(title);
        title.onPointerDown(this, info -> {
            app.scenes.main = new MainScene();
        }); 
    }

    override function update(delta:Float) {
        sceneText.pos(10, 10);
        title.pos(width * 0.5, height * 0.5);
        updateSquare(square);
    }

    override function destroy() {
        super.destroy();
    }
    function updateSquare(sq:Quad) {
        if (sq.x == 0) {
            sq.velocityX = Math.random() * 0.4;
        } else if (sq.x == width) {
            sq.velocityX = -Math.random() * 0.4;
        }
        if (sq.y == 0) {
            sq.velocityY = Math.random() * 0.6;
        } else if (sq.y == height) {
            sq.velocityY = -Math.random() * 0.6;
        }
    }
    override function resize(width, height:Float) {
        super.resize(width, height);
        if (options != null) {
            resizes();
        }
    }
        //resizes menu to fit new scene/screen size
    public function resizes() {
        options.size(width, height / 4);
        options.pos(width * 0.5, height - 10);
    }
}
class MenuOptions extends ceramic.Visual {
    var index = 1;
    public var Begin: Text;
    public var Credits: Text;
    public function new(scene:Scene, font:ceramic.BitmapFont) {
        super();
        Begin = new Text();
        Begin.content = "Begin";
        Begin.font = font;
        Begin.color = Color.CYAN;
        Begin.anchor(0.5, 0.5);
        Begin.scale(2.8, 2.8);
        Begin.pointSize = 20;

        Credits = new Text();
        Credits.content = "Credits";
        Credits.font = font;
        Credits.color = Color.GRAY;
        Credits.anchor(0.5, 0.5);
        Credits.scale(2.2, 2.2);
        Credits.pointSize = 20;

        //scene.add(this);
        this.size(screen.width, screen.height / 4);
        this.pos(screen.width * 0.5, screen.height - 10);
        //this.size(scene.width, scene.height / 4);
        //this.pos(scene.width * 0.5, scene.height - 10);
        this.anchor(0.5, 1);

        Credits.align = CENTER;
        Credits.pos(width * 0.6, height * 0.5);
        this.add(Credits);

        Begin.align = CENTER;
        Begin.pos(width * 0.4, height * 0.5);
        this.add(Begin);

        input.onKeyDown(scene, key -> {
            switch (key.scanCode) {
                case RIGHT:
                        if (index == 1) {
                            index = 2;
                        } else {
                            index = 1;
                        }
                case LEFT:
                    if (index == 2) {
                        index = 1;
                    } else {
                        index = 2;
                    }
                case ENTER:
                    if (index == 1) {
                        app.scenes.main = new MainScene();
                    } else {
                        return;
                    }
                case _:
                    return;
            }
            switch (index) {
                case 1:
                    Begin.tween(LINEAR, 0.3, 1, 2.8, (value, time) -> {
                        Begin.scale(value, value);
                        Begin.color = Color.CYAN;
                        //Begin.y -= 5 * (value - 0.8);
                    });
                    Credits.tween(LINEAR, 0.1, 1, 2, (value, time) -> {
                        Credits.scale(value, value);
                        Credits.color = Color.GRAY;
                        //Credits.y += 5 * (value - 0.2);
                    });
                case 2:
                    Begin.tween(LINEAR, 0.1, 1, 2, (value, time) -> {
                        Begin.scale(value, value);
                        Begin.color = Color.GRAY;
                        //Begin.y += 5 * (value - 2.2);
                        
                    });
                    Credits.tween(LINEAR, 0.3, 1, 2.8, (value, time) -> {
                        Credits.scale(value, value);
                        Credits.color = Color.CYAN;
                        //Credits.y -= 5 * (value - 0.8);
                    });
                case _:
                    index = 1;
            }
        });
    }
}