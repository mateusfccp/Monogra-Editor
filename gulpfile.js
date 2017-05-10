var gulp = require('gulp');

var concat = require('gulp-concat');
var cleanCSS = require('gulp-clean-css');
var elm = require('gulp-elm');
var nodemon = require('gulp-nodemon');
var rename = require('gulp-rename');
var runSequence = require('run-sequence');
var sass = require('gulp-sass');

// Elm related

gulp.task('elm-init', elm.init);

gulp.task('elm', ['elm-init'], function() {
    return gulp.src('src/elm/**/*.elm')
        .pipe(elm())
        .pipe(gulp.dest('public/dist/'));
});

gulp.task('elm-bundle', ['elm-init'], function() {
    return gulp.src('src/elm/**/*.elm')
        .pipe(elm.bundle('bundle.js'))
        .on('error', function(error) {
            console.log(error.toString());
            this.emit('end');
        })
        .pipe(rename('app.js'))
        .pipe(gulp.dest('public/dist/'));
});

// CSS related

gulp.task('sass', function() {
    return gulp.src('src/sass/**/*.scss')
        .pipe(sass().on('error', sass.logError))
        .pipe(gulp.dest('src/css'));
});

gulp.task('css', ['sass'], function() {
    return gulp.src(['src/css/**/reboot.css', 'src/css/**/bascss.min.css', 'src/css/**/*.css'])
        .pipe(concat('style.css'))
        .pipe(cleanCSS())
        .pipe(gulp.dest('public/dist/'));
});

gulp.task('build-css', function(callback) {
    runSequence('sass', 'css');
});

gulp.task('build', ['elm-bundle', 'build-css']);

gulp.task('serve-json', function() {
    nodemon({ script: 'api.js' });
})

gulp.task('debug-server', ['build', 'serve-json'], function() {
    var elm_watcher = gulp.watch('src/elm/**/*.elm', ['elm-bundle']);
    var css_watcher = gulp.watch('src/css/**/*.css', ['build-css']);
    var sass_watcher = gulp.watch('src/sass/**/*.scss', ['build-css']);
    elm_watcher.on('change', function(event) {
        console.log('Elm Watcher: File ' + event.path + ' was ' + event.type + ', running tasks...');
    });
    css_watcher.on('change', function(event) {
        console.log('CSS Watcher: File ' + event.path + ' was ' + event.type + ', running tasks...');
    });
    sass_watcher.on('change', function(event) {
        console.log('Sass Watcher: File ' + event.path + ' was ' + event.type + ', running tasks...');
    });
})