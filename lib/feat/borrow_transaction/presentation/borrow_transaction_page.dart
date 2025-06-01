import 'package:flutter/material.dart';

class BorrowTransactionPage extends StatefulWidget {
  const BorrowTransactionPage({super.key});

  @override
  State<BorrowTransactionPage> createState() => _BorrowTransactionPageState();
}

class _BorrowTransactionPageState extends State<BorrowTransactionPage> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _borrowerNames = ['Juan Dela Cruz', 'Maria Santos', 'Jose Rizal'];
  final List<String> _offices = ['City Planning', 'Engineering', 'Accounting'];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _officeController = TextEditingController();
  final TextEditingController _iscController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _officeController.dispose();
    _iscController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Borrow Transaction'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    return _borrowerNames.where((String option) {
                      return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                    _nameController.text = controller.text;
                    return TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: const InputDecoration(labelText: 'Borrower Name', border: UnderlineInputBorder()),
                      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                    );
                  },
                  onSelected: (String selection) {
                    _nameController.text = selection;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _contactController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Borrower Contact', border: UnderlineInputBorder()),
                  validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    return _offices.where((String option) {
                      return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                    _officeController.text = controller.text;
                    return TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: const InputDecoration(labelText: 'Borrower Office', border: UnderlineInputBorder()),
                      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                    );
                  },
                  onSelected: (String selection) {
                    _officeController.text = selection;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _iscController,
                  decoration: const InputDecoration(labelText: 'ISC / Arree', border: UnderlineInputBorder()),
                ),
                const SizedBox(height: 32),
                FilledButton(
                  style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Do something with the form data
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Form submitted')));
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
