{-# LANGUAGE OverloadedStrings #-} 
module Main where

import Hakyll

main :: IO ()
main = hakyll $ do
	match "images/*" $ do
		route idRoute
		compile copyFileCompiler
	
	match "css/*" $ do
		route idRoute
		compile compressCssCompiler

	match "index.html" $ do
		route idRoute
		compile $ pandocCompiler
			>>= loadAndApplyTemplate "templates/default.html" defaultContext
			>>= relativizeUrls

	create ["about.md", "links.md"] $ do
		route $ setExtension "html"
		compile $ pandocCompiler
			>>= loadAndApplyTemplate "templates/default.html" defaultContext
			>>= relativizeUrls
		
	match "templates/*" $ compile templateBodyCompiler
