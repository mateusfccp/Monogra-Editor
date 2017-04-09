var gulp = require('gulp');

var concat = require('gulp-concat');
var elm	= require('gulp-elm');
var minifyCSS = require('gulp-minify-css');
var rename = require ('gulp-rename');

// Elm related

gulp.task('elm-init', elm.init);

gulp.task('elm', ['elm-init'], function(){
	return gulp.src('src/elm/**/*.elm')
	           .pipe(elm())
	           .pipe(gulp.dest('dist/'));
});

gulp.task('elm-bundle', ['elm-init'], function(){
	return gulp.src('src/elm/**/*.elm')
	           .pipe(elm.bundle('bundle.js'))
	           .pipe(rename('app.js'))
	           .pipe(gulp.dest('dist/'));
});

// CSS related

gulp.task('css-bundle', function () {
	return gulp.src('src/css/**/*.css')
	           .pipe(concat('style.css'))
			   .pipe(minifyCSS())
			   .pipe(gulp.dest('dist/'));
});

gulp.task('build', ['elm-bundle', 'css-bundle']);
