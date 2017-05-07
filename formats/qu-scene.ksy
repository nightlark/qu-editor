meta:
  id: qu_scene
  application: QU Mixers
  endian: le
  encoding: utf-8
  file-extension: dat

seq:
  - id: header
    type: header
  - id: header_end
    type: section_end
  - id: chan
    type: channel_entry
    repeat: expr
    repeat-expr: 60
  - id: channel_end
    type: section_end
  - id: fx_rack
    type: fx_rack_entry
    repeat: expr
    repeat-expr: 4
  - id: fx_rack_end
    type: section_end
  - id: sect4
    size: 9600
  - id: sect4_end
    type: section_end
  - id: sect5
    size: 0
  - id: sect5_end
    type: section_end
  - id: sect6
    size: 4
  - id: sect6_end
    type: section_end
  - id: sect7
    size: 12
  - id: sect7_end
    type: section_end
  - id: sect8
    size: 24
  - id: sect8_end
    type: section_end
  - id: sect9
    size: 24
  - id: sect9_end
    type: section_end
  - id: sect10
    size: 48
  - id: sect10_end
    type: section_end
  - id: sect11
    size: 168
  - id: sect11_end
    type: section_end
  - id: sect12
    size: 4096
  - id: sect12_end
    type: section_end
  - id: crc
    type: u4


types:
  header:
    seq:
      - id: magic
        contents: [0xA1, 0x00, 0xFE]
      - id: id
        type: u1
      - id: version
        type: version
      - id: unk1
        size: 4
      - id: name
        type: str
        size: 13
      - id: unk2
        size: 19
      
    types:
      version:
        seq:
          - id: major
            type: b7
          - id: const_true
            type: b1
          - id: minor
            type: u1
          - id: revision
            type: u2
    
  section_end:
    seq:
      - id: number
        type: u1
      - id: terminator
        contents: [0xA5, 0xA5, 0xA5]
    
  fx_rack_entry:
    seq:
      - id: unk1
        size: 2
      - id: name
        type: str
        size: 20
      - id: unk_params
        size: 52
    
  channel_entry:
    seq:
      - id: unk1
        type: u1
      - id: peq
        type: peq
      - id: unk2
        size: 1
      - id: comp
        type: compressor
      - id: gate
        type: gate
      - id: unk3
        size: 65
      - id: hpf
        type: hpf
      - id: unk4
        size: 1
      - id: delay
        type: delay
      - id: unk5
        size: 1
      - id: fader
        type: u2
      - id: gain
        type: u2
      - id: trim
        type: u2
      - id: qu_drive_on_off
        type: u1
      - id: phantom_on_off
        type: u1
      - id: phase_flip_on_off
        type: u1
      - id: unk6
        size: 1
      - id: mute_on_off
        type: u1
      - id: fx_insert_on_off
        type: u1
      - id: unk7
        size: 1
      - id: d_snake_on_off
        type: u1
      - id: unk8
        size: 4
      - id: linked
        type: u1
      - id: unk9
        size: 3
      - id: preamp_linked
        type: u1
      - id: dynamicssidechain_pan_fader_mute_linked
        type: u1
      - id: unk10
        size: 3
      - id: d_snake_gain
        type: u1
      - id: unk11
        size: 1
      - id: pad_20db_on_off
        type: u1
      - id: name
        type: str
        size: 6
      - id: unk12
        size: 6
      - id: ducker
        type: ducker
      - id: number
        type: u1
      - id: unk13
        size: 8
      
    types:
      delay:
        seq:
          - id: time
            type: u2
          - id: on_off
            type: u1
        
      hpf:
        seq:
          - id: frequency
            type: u2
          - id: in_out
            type: u1
        
      peq:
        seq:
          - id: lf
            type: peq_setting
          - id: unk1
            size: 2
          - id: lm
            type: peq_setting
          - id: unk2
            size: 2
          - id: hm
            type: peq_setting
          - id: unk3
            size: 2
          - id: hf
            type: peq_setting
          - id: unk4
            size: 1
          - id: lf_shelf
            type: u1
          - id: hf_shelf
            type: u1
          - id: in_out
            type: u1
        
      peq_setting:
        seq:
          - id: gain
            type: u1
          - id: frequency
            type: u2
          - id: width
            type: u1
        
      compressor:
        seq:
          - id: attack
            type: u2
          - id: release
            type: u2
          - id: knee
            type: u1
          - id: unk1
            size: 1
          - id: ratio
            type: u1
          - id: unk2
            size: 2
          - id: threshold
            type: u1
          - id: unk3
            size: 1
          - id: gain
            type: u1
          - id: type
            type: u1
          - id: in_out
            type: u1
        
      gate:
        seq:
          - id: attack
            type: u2
          - id: release
            type: u2
          - id: hold
            type: u2
          - id: unk1
            size: 1
          - id: threshold
            type: u1
          - id: unk2
            size: 1
          - id: depth
            type: u1
          - id: in_out
            type: u1
        
      ducker:
        seq:
          - id: attack
            type: u2
          - id: release
            type: u2
          - id: hold
            type: u2
          - id: unk1
            size: 1
          - id: threshold
            type: u1
          - id: unk2
            size: 2
          - id: on_off
            type: u1
          - id: trigger_input
            type: u1
          - id: single_gang
            type: u1
          - id: unk3
            size: 1
          - id: insert
            type: u1
