import ceramic.StateMachineBase;
import ceramic.Text;
import ceramic.Quad;
import ceramic.Color;
import ceramic.Scene;

using ceramic.VisualTransition;
class MainMenu extends Scene {
    var sceneText = new Text();
    var title = new Text();
    var square:Square;
    var options:MenuOptions;
    override function preload() {
        assets.add(Images.DOINGIT);
        assets.add(Fonts.DAYDREAM);
        assets.add(Fonts.GRAPE_SODA);
    }
    override function create() {
        super.create();
        options = new MenuOptions(assets.font(Fonts.GRAPE_SODA));
        add(options);

        square = new Square(150);
        add(square);

        square.depth = -20;
        square.pos(width / 2, height / 2);
        add(square);

        //add scene name
        sceneText.content = "Main Menu";
        sceneText.pointSize = 15;
        sceneText.align = CENTER;
        sceneText.font = assets.font(Fonts.DAYDREAM);
        sceneText.pos(10, 10);
        add(sceneText);

        title.content = "Doin' It";
        title.align = CENTER;
        title.pointSize = 45;
        title.anchor(0.5, 0.5);
        title.pos(width * 0.5, height * 0.4);
        title.font = assets.font(Fonts.DAYDREAM);
        add(title);

        title.onPointerDown(this, info -> {
            app.scenes.main = new MainScene();
        }); 
    }

    override function update(delta:Float) {
        sceneText.pos(10, 10);
        title.pos(width * 0.5, height * 0.4);
        square.update(delta);
    }

    override function destroy() {
        super.destroy();
    }
    override function resize(width, height:Float) {
        super.resize(width, height);
        if (options != null) {
            options.resize();
        }
    }
}
class MenuOptions extends ceramic.Visual {
    var index = 1;
    public var begin: Text;
    public var credits: Text;
    public function new(font:ceramic.BitmapFont) {
        super();
        begin = new Text();
        begin.content = "BEGIN";
        begin.font = font;
        begin.color = Color.RED;
        begin.anchor(0.5, 0.5);
        begin.pointSize = 20;
        begin.scale(2.8, 2.8);
        begin.align = CENTER;
        //begin.pos(width * 0.4, height * 0.5);

        credits = new Text();
        credits.content = "CREDITS";
        credits.font = font;
        credits.color = Color.GRAY;
        credits.anchor(0.5, 0.5);
        credits.pointSize = 20;
        credits.scale(2.2, 2.2);
        credits.align = CENTER;

        this.anchor(0.5, 1);
        resize();

        add(credits);
        add(begin);

        input.onKeyUp(app.scenes.main, key -> {
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
                    begin.tween(LINEAR, 0.3, 1, 2.8, (value, time) -> {
                        begin.scale(value, value);
                        begin.color = Color.RED;
                        //begin.y -= 5 * (value - 0.8);
                    });
                    credits.tween(LINEAR, 0.1, 1, 2, (value, time) -> {
                        credits.scale(value, value);
                        credits.color = Color.GRAY;
                        //credits.y += 5 * (value - 0.2);
                    });
                case 2:
                    begin.tween(LINEAR, 0.1, 1, 2, (value, time) -> {
                        begin.scale(value, value);
                        begin.color = Color.GRAY;
                        //begin.y += 5 * (value - 2.2);
                        
                    });
                    credits.tween(LINEAR, 0.3, 1, 2.8, (value, time) -> {
                        credits.scale(value, value);
                        credits.color = Color.CYAN;
                        //credits.y -= 5 * (value - 0.8);
                    });
                case _:
                    index = 1;
            }
        });
    }
    //resizes menu to fit new scene/screen size
    public function resize() {
        this.size(screen.width, screen.height / 3.5);
        this.pos(screen.width * 0.5, screen.height - 10);
        begin.pos(width * 0.4, height * 0.5);
        credits.pos(width * 0.6, height * 0.5);
    }
}
class Square extends ceramic.Quad {
    var vx:Float;
    var vy:Float;
    public function new(velocity:Float) {
        super();
        size(30, 30);
        anchor(0.5, 0.5);
        this.vx = velocity;
        this.vy = velocity;

    }
    public function update(dt:Float) {
        x += vx * dt;
        y += vy * dt;
        wallBounce();
        /*this.tween(LINEAR, 1, 0, sq.x + vx * dt, (v, t) -> {
            sq.x = v;
        });
        this.tween(LINEAR, 1, 0, sq.y + vy * dt, (v, t) -> {
            sq.y = v;
        });*/
    }
    public function wallBounce() {
        if (x <= width || x >= screen.width - width) {
            vx = -vx;
        }
        if (y <= height || y >= screen.height - height) {
            vy = -vy;
        }
    }
}