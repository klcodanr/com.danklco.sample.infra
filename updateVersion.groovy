#!/usr/bin/env groovy
def file = args[0];
def app = args[1];
def version = args[2];
def properties = new Properties();
def propFile = new File(file);
properties.load(propFile.newDataInputStream());
properties.setProperty(app, version);
properties.store(propFile.newWriter(), null);