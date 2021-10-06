# Encryptable

![Main workflow](https://github.com/jocmp/encryptable/actions/workflows/main.yml/badge.svg)

A demo module to show how DSLs work in Ruby applications. The library provides a script that converts a credit card number when prompted using base conversion to mimick how encryption works within a real application. The Encryptable module is modified from the version in a talk given by [Ufuk Kayserilioglu](https://github.com/paracycle) at [RubyKaigi Takeout 2021](https://rubykaigi.org/2021-takeout/presentations/paracycle.html).

## Getting started

Assumes [rbenv](https://github.com/rbenv/rbenv) is installed.

Run `bin/encryptable` to receive a prompt to enter a fake credit card number:

```sh
./bin/encryptable
Enter a (fake) credit card number!
411111111111111
Your encrypted† credit card number is:
34313131313131313131313131313131
†Not really encrypted!
```

Behind the scenes, the "attr_encryptable" DSL method relies on an accessor called "number_encrypted." The accessor can be implemented at runtime on a model using Rails' [Database schema](https://guides.rubyonrails.org/active_record_migrations.html#model-generators) file in a real application.

### Running the tests

To run the tests, enter the following command

```
bundle exec rake test
```

## Commentary

In general, encrypted data is more understandable when it is automatically decrypted to cleartext for a user. In a codebase, an application developer should be able to avoid encryption implementation details in the same way that a web browser user is shielded from manually decrypting HTTPS webpages. Just like the OSI model, a codebase can also have a [presentation layer](https://en.wikipedia.org/wiki/Presentation_layer) that is accessible when necessary but invisible in the common case.
