TextFormField(
                  onTap: () {
                    if (_isLabelVisible) {
                      setState(() {
                        _isLabelVisible = false;
                      });
                    }
                  },
                  controller: inputControllerTag,
                  textAlign: TextAlign.center,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "장소명을 입력해주세요";
                    }
                    return null;
                  },
                  style: TextStyle(
                    color: Colors.green,
                    decorationColor: Colors.red,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    // labelText: '등록하고자 하는 장소명을 입력해주세요',
                    labelStyle: TextStyle(color: Colors.green),
                    labelText: _isLabelVisible ? label : '',

                    fillColor: Colors.green,
                    prefixIcon: Icon(
                      Icons.place,
                      color: Colors.green,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      color: Colors.green,
                      onPressed: () {
                        _textEditingController.clear();
                        if (!_isLabelVisible) {
                          setState(() {
                            _isLabelVisible = true;
                            label = '등록하고자 하는 장소명을 입력해주세요';
                          });
                        }
                      },
                    ),
                    // hintText: '등록하고자 하는 장소명을 입력해주세요',
                    // hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(
                        color: Colors.green, // 원하는 색상으로 변경
                      ),
                    ),
                    // prefixText: 'PrefixText',
                    // suffixText: 'Suffixtext',
                  ),
                ),
