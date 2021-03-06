import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_clock/providers/Salon.dart';
import 'package:salon_clock/providers/barbers.dart';
import 'package:salon_clock/providers/product.dart';
import 'package:salon_clock/providers/salon_provider.dart';

class EditSalonScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditSalonScreenState createState() => _EditSalonScreenState();
}

class _EditSalonScreenState extends State<EditSalonScreen> {
  final _phoneFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _locationDescriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedSalon = Salon(
    id: null,
    title: '',
    description: '',
    phoneNo: '',
    imageLogo: '',
    locationDesc: '',
  );
  var _initValues = {
    'title': '',
    'description': '',
    'phoneNo': '',
    'imageLogo': '',
    'locationDesc': '',
  };
  var _isInit = true;
  var _isLoading = false;
  @override
  void dispose() {
    // TODO: we need to dispose the nodes otherwise will stick around in memory and will lead to a memory leak.
    _descriptionFocusNode.dispose();
    _phoneFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _locationDescriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      final salonId = ModalRoute.of(context).settings.arguments as String;
      if (salonId != null) {
        _editedSalon = Provider.of<SalonProvider>(context, listen: false)
            .findById(salonId);
        _initValues = {
          'title': _editedSalon.title,
          'description': _editedSalon.description,
          'phoneNo': _editedSalon.phoneNo,
          'imageLogo': '',
          // 'imageLogo': _editedSalon.imageLogo,
          'locationDesc': _editedSalon.locationDesc,
        };
        _imageUrlController.text = _editedSalon.imageLogo;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    _imageUrlFocusNode.addListener((_updateImageUrl));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Salon'),
        actions: [
          IconButton(
              onPressed: () {
                _saveForm();
              },
              icon: Icon(Icons.save))
        ],
      ),
      body:
          _isLoading // ?????? ???????????????????? ?????? ?????????? ?????????? ?????????????? ???????? ?????? ?????????? ???????? ???????????? ?????????? ?????????? ?????????? ???? ?????????????? ????????
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _form,
                    child: ListView(
                      children: [
                        TextFormField(
                          initialValue: _initValues['title'],
                          decoration: const InputDecoration(labelText: 'Title'),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Provide a Salon title!";
                            }
                            return null; //?Returning Null here means that there is no error.
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_phoneFocusNode);
                          },
                          onSaved: (newValue) {
                            _editedSalon = Salon(
                              id: _editedSalon.id,
                              title: newValue,
                              description: _editedSalon.description,
                              phoneNo: _editedSalon.phoneNo,
                              imageLogo: _editedSalon.imageLogo,
                              locationDesc: _editedSalon.locationDesc,
                              isFavorite: _editedSalon.isFavorite,
                              // barbers: [],
                              // products: [],
                              // services: [],
                            );
                          },
                        ),
                        TextFormField(
                          initialValue: _initValues['phoneNo'],
                          decoration:
                              const InputDecoration(labelText: 'Phone Number'),
                          textInputAction: TextInputAction.next,
                          focusNode: _phoneFocusNode,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter salon phone number!";
                            }
                            if (value.length < 10) {
                              return "Please enter a valid phone Number!";
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_locationDescriptionFocusNode);
                          },
                          onSaved: (newValue) {
                            _editedSalon = Salon(
                              id: _editedSalon.id,
                              title: _editedSalon.title,
                              description: _editedSalon.description,
                              phoneNo: newValue,
                              imageLogo: _editedSalon.imageLogo,
                              locationDesc: _editedSalon.locationDesc,
                              isFavorite: _editedSalon.isFavorite,
                              // barbers: [],
                              // products: [],
                              // services: [],
                            );
                          },
                        ),
                        TextFormField(
                          initialValue: _initValues['locationDesc'],
                          decoration: const InputDecoration(
                              labelText: 'Location Description'),
                          textInputAction: TextInputAction.next,
                          focusNode: _locationDescriptionFocusNode,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter Location Description!";
                            }

                            return null;
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_descriptionFocusNode);
                          },
                          onSaved: (newValue) {
                            _editedSalon = Salon(
                              id: _editedSalon.id,
                              title: _editedSalon.title,
                              description: _editedSalon.description,
                              phoneNo: _editedSalon.phoneNo,
                              imageLogo: _editedSalon.imageLogo,
                              locationDesc: newValue,
                              isFavorite: _editedSalon.isFavorite,
                              // barbers: [],
                              // products: [],
                              // services: [],
                            );
                          },
                        ),
                        TextFormField(
                          initialValue: _initValues['description'],
                          decoration:
                              const InputDecoration(labelText: 'Description'),
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          focusNode: _descriptionFocusNode,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter Salon description!";
                            }
                            if (value.length < 10) {
                              return "Description should be at leats 10 characters long.";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _editedSalon = Salon(
                              id: _editedSalon.id,
                              title: _editedSalon.title,
                              description: newValue,
                              phoneNo: _editedSalon.phoneNo,
                              imageLogo: _editedSalon.imageLogo,
                              locationDesc: _editedSalon.locationDesc,
                              isFavorite: _editedSalon.isFavorite,
                              // barbers: [],
                              // products: [],
                              // services: [],
                            );
                          },
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                                width: 100,
                                height: 100,
                                margin:
                                    const EdgeInsets.only(top: 8, right: 10),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                ),
                                child: _imageUrlController.text.isEmpty
                                    ? const Text("Enter a Url")
                                    : FittedBox(
                                        child: Image.network(
                                            _imageUrlController.text),
                                        fit: BoxFit.cover,
                                      )),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Image URL'),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction
                                    .done, //  When we done we will put this which will submit the form
                                controller: _imageUrlController,
                                focusNode: _imageUrlFocusNode,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please enter salon Image URL!";
                                  }
                                  if (!value.startsWith('http') &&
                                      !value.startsWith('https')) {
                                    return "Please enter a valid URL!";
                                  }
                                  if (!value.endsWith('.png') &&
                                      !value.endsWith('.jpg') &&
                                      !value.endsWith('.jpeg')) {
                                    return "Please enter a valid image URL!";
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (_) {
                                  _saveForm();
                                },
                                onSaved: (newValue) {
                                  _editedSalon = Salon(
                                    id: _editedSalon.id,
                                    title: _editedSalon.title,
                                    description: _editedSalon.description,
                                    phoneNo: _editedSalon.phoneNo,
                                    imageLogo: newValue,
                                    locationDesc: _editedSalon.locationDesc,
                                    isFavorite: _editedSalon.isFavorite,
                                    // barbers: [],
                                    // products: [],
                                    // services: [],
                                    // barbers: [
                                    //   Barbers(
                                    //       barberID: _editedSalon.barbers[8].barberID,
                                    //       name: _editedSalon.barbers[8].name,
                                    //       career: _editedSalon.barbers[8].career,
                                    //       imageURL: _editedSalon.barbers[8].imageURL,
                                    //       nationality:
                                    //           _editedSalon.barbers[8].nationality)
                                    // ]
                                    //
                                  );
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
    );
  } //------------------------------------------------------------------------------------------------

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  //------------------------------------------------------------------------------------------------
  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedSalon.id != null) {
      await Provider.of<SalonProvider>(context, listen: false)
          .updateSalon(_editedSalon.id, _editedSalon);
    } else {
      try {
        await Provider.of<SalonProvider>(context, listen: false)
            .addSalon(_editedSalon);
      } catch (error) {
        await showDialog<Null>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("An error occured!"),
            content: const Text("Something went wrong!"),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).maybePop();
                  },
                  child: Text("Got It"))
            ],
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).maybePop();
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }
}
