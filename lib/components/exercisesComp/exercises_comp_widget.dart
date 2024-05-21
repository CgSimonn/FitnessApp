import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'exercises_comp_model.dart';
export 'exercises_comp_model.dart';

class ExercisesCompWidget extends StatefulWidget {
  const ExercisesCompWidget({super.key});

  @override
  State<ExercisesCompWidget> createState() => _ExercisesCompWidgetState();
}

class _ExercisesCompWidgetState extends State<ExercisesCompWidget> {
  late ExercisesCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExercisesCompModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsets.all(14),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFDFDFD),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: TextFormField(
                      controller: _model.textController,
                      focusNode: _model.textFieldFocusNode,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0,
                          ),
                      validator:
                          _model.textControllerValidator.asValidator(context),
                    ),
                  ),
                ),
                FlutterFlowIconButton(
                  borderColor: Colors.white,
                  borderRadius: 20,
                  borderWidth: 1,
                  buttonSize: 40,
                  fillColor: Color(0x4CFFFFFF),
                  icon: Icon(
                    Icons.search_sharp,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24,
                  ),
                  onPressed: () {
                    print('IconButton pressed ...');
                  },
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Add(${valueOrDefault<String>(
                    _model.total?.toString(),
                    '0',
                  )})',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0,
                      ),
                ),
              ],
            ),
            StreamBuilder<List<ExercisesRecord>>(
              stream: queryExercisesRecord(),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  );
                }
                List<ExercisesRecord> listViewExercisesRecordList =
                    snapshot.data!;
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: listViewExercisesRecordList.length,
                  itemBuilder: (context, listViewIndex) {
                    final listViewExercisesRecord =
                        listViewExercisesRecordList[listViewIndex];
                    return Theme(
                      data: ThemeData(
                        checkboxTheme: CheckboxThemeData(
                          visualDensity: VisualDensity.compact,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                        unselectedWidgetColor:
                            FlutterFlowTheme.of(context).secondaryText,
                      ),
                      child: CheckboxListTile(
                        value: _model.checkboxListTileValueMap[
                                listViewExercisesRecord] ??=
                            FFAppState()
                                .workout
                                .exercises
                                .map((e) => e.exerciseRefs?.id)
                                .withoutNulls
                                .toList()
                                .contains(listViewExercisesRecord.reference.id),
                        onChanged: (newValue) async {
                          setState(() => _model.checkboxListTileValueMap[
                              listViewExercisesRecord] = newValue!);
                          if (newValue!) {
                            setState(() {
                              _model.total = _model.total! + 1;
                            });
                            setState(() {
                              FFAppState().updateWorkoutStruct(
                                (e) => e
                                  ..updateExercises(
                                    (e) => e.add(ExerciseStruct(
                                      exerciseRefs:
                                          listViewExercisesRecord.reference,
                                      sets: functions.createSets(),
                                    )),
                                  ),
                              );
                            });
                          } else {
                            setState(() {
                              _model.total = _model.total! + -1;
                            });
                            setState(() {
                              FFAppState().updateWorkoutStruct(
                                (e) => e
                                  ..updateExercises(
                                    (e) => e.add(ExerciseStruct(
                                      exerciseRefs:
                                          listViewExercisesRecord.reference,
                                    )),
                                  ),
                              );
                            });
                          }
                        },
                        title: Text(
                          listViewExercisesRecord.name,
                          style:
                              FlutterFlowTheme.of(context).titleLarge.override(
                                    fontFamily: 'Outfit',
                                    letterSpacing: 0,
                                  ),
                        ),
                        subtitle: Text(
                          listViewExercisesRecord.bodyPart,
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                  ),
                        ),
                        tileColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        activeColor: FlutterFlowTheme.of(context).primary,
                        checkColor: FlutterFlowTheme.of(context).info,
                        dense: false,
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
