![cobsy](example/cobsy.png)

#A Component OBject SYstem for Perl

Cobsy is a way to build and extend objects at runtime using components, which function like packages. A Cobsy component exports attributes and methods to add to a Cobsy
Object (a Cob). Cobsy can form the basis for a component entity system, or any other project without a clear object hierarchy where you want to avoid the rigidity of
standard class-based inheritance.

## Components
A component is a "runtime package" which provides attributes and methods which are able to be installed into a Cob.

---
### `initialize([arguments])`
Define code to be run when the component is instantiated. Arguments (in the form of an array ref) can also be passed to the component. Initialize is mainly used to setup private
data associated with the component

### `afterInstall(cob)`
Define code to run immediately after this component is installed into a Cob

### `requires()`
Return a list (as an arrayref) of components required by this component

### `setPriority()`
Return an int representing the priority of this component (default: 1). Lower priorities will be loaded first. Priority is used when installing components and requiring components within a component.
Set a higher priority when you want to override a method exported from a different component or when you need a guarantee that a component will be available in a given place.

### `exportAttributes()`
Return a hashref of attribute keys to their values. Attributes will be available from the Cob via `$cob->attributes()`. If you don't want an attribute to be "public" or want to avoid polluting the Cob,
prefer storing properties only in the component (this will usually be what you want to do)

### `exportMethods()`
Return a hashref of keys representing method names to a coderef. Keys will be available through the Cob this component installs into via `$cob->method()`, for example

## Objects (Cobs)
Objects are containers for components. To create an object with a given set of components loaded in,

```perl
my $object = Cobsy::Object->new([
  'Test::Component::Named', # exports getName and setName
  'Test::Component::Aged' # exports getAge and setAge
]);
$object->setName('guy');
$object->setAge(200);
```

or, to use components initialized with given data,

```perl
my $object = Cobsy::Object->new({
  'Test::Component::Named' => ['guy'], # exports getName
  'Test::Component::Aged' => [200] # exports getAge
});
$object->getName(); # returns "guy"
$object->getAge(); # returns 200
```

Components will be loaded into a Cob by their priority.

To create a new Cob from another with additional components loaded, use `extend`

```perl
my $extended = $object->extend({
  'Test::Component::Specied' => "human" # exports getSpecies
});
$extended->getName(); # returns "guy"
$extended->getSpecies(); # returns "human"
$object->getSpecies(); # dies, because the Specied component is only available in $extended
```
